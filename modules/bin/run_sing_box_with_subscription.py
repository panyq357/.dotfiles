#!/usr/bin/env python3
"""
sub2singbox —— 订阅转 sing-box 配置工具

功能：
1. 下载订阅链接内容
2. Base64 解码，解析节点（支持 ss / vmess / trojan / vless / hysteria2）
3. 列出节点，供用户选择
4. 根据所选节点生成 sing-box 的 config.json
5. 调用本机的 sing-box 使用生成的配置启动

用法：
    python3 sub2singbox.py <订阅链接>             # 首次运行，链接会被保存
    python3 sub2singbox.py                       # 之后可直接运行，自动读取已保存的链接
    python3 sub2singbox.py <订阅链接> --no-run    # 只生成配置，不启动
    python3 sub2singbox.py <订阅链接> -p 7890     # 指定本地监听端口
    python3 sub2singbox.py --bin /usr/local/bin/sing-box
    python3 sub2singbox.py -u <新订阅链接>        # 更新已保存的订阅链接

订阅链接会保存在当前目录下的 .sub_url 文件中（可用 --url-file 自定义路径）。
"""

import argparse
import base64
import json
import os
import subprocess
import sys
import urllib.parse
import urllib.request
from dataclasses import dataclass


DEFAULT_URL_FILE = ".sub_url"


# ---------------------------------------------------------------------------
# 数据结构
# ---------------------------------------------------------------------------

@dataclass
class Node:
    tag: str
    outbound: dict  # sing-box outbound 配置片段


# ---------------------------------------------------------------------------
# 订阅链接的读取 / 保存
# ---------------------------------------------------------------------------

def load_saved_url(path: str) -> str | None:
    if os.path.isfile(path):
        with open(path, "r", encoding="utf-8") as f:
            saved = f.read().strip()
        return saved or None
    return None


def save_url(path: str, url: str) -> None:
    with open(path, "w", encoding="utf-8") as f:
        f.write(url.strip() + "\n")
    # 订阅链接通常包含私密 token，收紧一下文件权限（Windows 下会静默忽略）
    try:
        os.chmod(path, 0o600)
    except OSError:
        pass


def resolve_url(args) -> str:
    """确定本次使用的订阅链接，并在需要时保存/更新到本地文件。"""
    url_file = args.url_file

    # 显式传入 -u/--url 表示更新已保存的链接
    if args.set_url:
        save_url(url_file, args.set_url)
        print(f"订阅链接已保存到 {url_file}")
        return args.set_url

    # 位置参数传入了链接
    if args.url:
        save_url(url_file, args.url)
        return args.url

    # 尝试读取已保存的链接
    saved = load_saved_url(url_file)
    if saved:
        print(f"使用已保存的订阅链接（来自 {url_file}）")
        return saved

    # 都没有，交互式输入，并保存供下次使用
    url = input("请输入订阅链接: ").strip()
    if url:
        save_url(url_file, url)
        print(f"订阅链接已保存到 {url_file}，下次可直接运行脚本无需再输入。")
    return url


# ---------------------------------------------------------------------------
# 工具函数
# ---------------------------------------------------------------------------

def b64decode_padded(s: str) -> bytes:
    """兼容 URL-safe / 缺少 padding 的 base64 字符串。"""
    s = s.strip().replace("-", "+").replace("_", "/")
    padding = (-len(s)) % 4
    s += "=" * padding
    return base64.b64decode(s)


# ---------------------------------------------------------------------------
# 1. 下载订阅
# ---------------------------------------------------------------------------

def fetch_subscription(url: str, timeout: int = 15) -> str:
    req = urllib.request.Request(
        url,
        headers={"User-Agent": "sing-box-subscriber/1.0"},
    )
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        raw = resp.read()
    return raw.decode("utf-8", errors="ignore")


# ---------------------------------------------------------------------------
# 2. 解析订阅内容
# ---------------------------------------------------------------------------

def decode_subscription(content: str) -> list:
    """订阅内容通常整体是 base64，解码后每行一个节点 URI。
    也兼容订阅本身就是明文 URI 列表的情况。"""
    content = content.strip()
    if "://" not in content:
        try:
            decoded = b64decode_padded(content).decode("utf-8", errors="ignore")
            if "://" in decoded:
                content = decoded
        except Exception:
            pass
    return [line.strip() for line in content.splitlines() if line.strip()]


def parse_ss(uri: str, idx: int) -> Node | None:
    # ss://BASE64(method:password)@host:port#tag
    # 或旧格式: ss://BASE64(method:password@host:port)#tag
    body = uri[len("ss://"):]
    tag = f"ss-{idx}"
    if "#" in body:
        body, frag = body.split("#", 1)
        tag = urllib.parse.unquote(frag) or tag

    try:
        if "@" in body:
            userinfo_b64, hostport = body.split("@", 1)
            try:
                userinfo = b64decode_padded(userinfo_b64).decode("utf-8")
            except Exception:
                userinfo = urllib.parse.unquote(userinfo_b64)
            method, password = userinfo.split(":", 1)
            hostport = hostport.split("?")[0]
            host, port = hostport.rsplit(":", 1)
        else:
            decoded = b64decode_padded(body.split("?")[0]).decode("utf-8")
            method_password, hostport = decoded.split("@", 1)
            method, password = method_password.split(":", 1)
            host, port = hostport.rsplit(":", 1)
    except Exception:
        return None

    outbound = {
        "type": "shadowsocks",
        "tag": tag,
        "server": host,
        "server_port": int(port),
        "method": method,
        "password": password,
    }
    return Node(tag=tag, outbound=outbound)


def parse_vmess(uri: str, idx: int) -> Node | None:
    body = uri[len("vmess://"):]
    try:
        data = json.loads(b64decode_padded(body).decode("utf-8"))
    except Exception:
        return None

    tag = data.get("ps") or f"vmess-{idx}"
    net = data.get("net", "tcp")

    outbound = {
        "type": "vmess",
        "tag": tag,
        "server": data.get("add"),
        "server_port": int(data.get("port", 443)),
        "uuid": data.get("id"),
        "security": "auto",
        "alter_id": int(data.get("aid", 0) or 0),
    }

    if data.get("tls") == "tls":
        outbound["tls"] = {
            "enabled": True,
            "server_name": data.get("sni") or data.get("host") or data.get("add"),
            "insecure": False,
        }

    if net == "ws":
        headers = {"Host": data["host"]} if data.get("host") else {}
        outbound["transport"] = {
            "type": "ws",
            "path": data.get("path", "/"),
            "headers": headers,
        }
    elif net == "grpc":
        outbound["transport"] = {
            "type": "grpc",
            "service_name": data.get("path", ""),
        }

    return Node(tag=tag, outbound=outbound)


def parse_trojan(uri: str, idx: int) -> Node | None:
    parsed = urllib.parse.urlparse(uri)
    if not parsed.hostname:
        return None
    tag = urllib.parse.unquote(parsed.fragment) or f"trojan-{idx}"
    password = urllib.parse.unquote(parsed.username or "")
    host = parsed.hostname
    port = parsed.port or 443
    qs = urllib.parse.parse_qs(parsed.query)

    outbound = {
        "type": "trojan",
        "tag": tag,
        "server": host,
        "server_port": port,
        "password": password,
        "tls": {
            "enabled": True,
            "server_name": qs.get("sni", [host])[0],
            "insecure": qs.get("allowInsecure", ["0"])[0] in ("1", "true"),
        },
    }

    net = qs.get("type", ["tcp"])[0]
    if net == "ws":
        outbound["transport"] = {
            "type": "ws",
            "path": qs.get("path", ["/"])[0],
            "headers": {"Host": qs.get("host", [host])[0]},
        }
    elif net == "grpc":
        outbound["transport"] = {
            "type": "grpc",
            "service_name": qs.get("serviceName", [""])[0],
        }

    return Node(tag=tag, outbound=outbound)


def parse_vless(uri: str, idx: int) -> Node | None:
    parsed = urllib.parse.urlparse(uri)
    if not parsed.hostname:
        return None
    tag = urllib.parse.unquote(parsed.fragment) or f"vless-{idx}"
    uuid = parsed.username
    host = parsed.hostname
    port = parsed.port or 443
    qs = urllib.parse.parse_qs(parsed.query)

    outbound = {
        "type": "vless",
        "tag": tag,
        "server": host,
        "server_port": port,
        "uuid": uuid,
    }

    flow = qs.get("flow", [""])[0]
    if flow:
        outbound["flow"] = flow

    security = qs.get("security", ["none"])[0]
    if security in ("tls", "reality"):
        tls_cfg = {
            "enabled": True,
            "server_name": qs.get("sni", [host])[0],
            "insecure": qs.get("allowInsecure", ["0"])[0] in ("1", "true"),
        }
        if security == "reality":
            tls_cfg["reality"] = {
                "enabled": True,
                "public_key": qs.get("pbk", [""])[0],
                "short_id": qs.get("sid", [""])[0],
            }
        if qs.get("fp"):
            tls_cfg["utls"] = {"enabled": True, "fingerprint": qs.get("fp", [""])[0]}
        outbound["tls"] = tls_cfg

    net = qs.get("type", ["tcp"])[0]
    if net == "ws":
        outbound["transport"] = {
            "type": "ws",
            "path": qs.get("path", ["/"])[0],
            "headers": {"Host": qs.get("host", [host])[0]},
        }
    elif net == "grpc":
        outbound["transport"] = {
            "type": "grpc",
            "service_name": qs.get("serviceName", [""])[0],
        }

    return Node(tag=tag, outbound=outbound)


def parse_hysteria2(uri: str, idx: int) -> Node | None:
    uri = "hysteria2://" + uri.split("://", 1)[1]
    parsed = urllib.parse.urlparse(uri)
    if not parsed.hostname:
        return None
    tag = urllib.parse.unquote(parsed.fragment) or f"hysteria2-{idx}"
    password = urllib.parse.unquote(parsed.username or "")
    host = parsed.hostname
    port = parsed.port or 443
    qs = urllib.parse.parse_qs(parsed.query)

    outbound = {
        "type": "hysteria2",
        "tag": tag,
        "server": host,
        "server_port": port,
        "password": password,
        "tls": {
            "enabled": True,
            "server_name": qs.get("sni", [host])[0],
            "insecure": qs.get("insecure", ["0"])[0] in ("1", "true"),
        },
    }
    return Node(tag=tag, outbound=outbound)


PARSERS = {
    "ss://": parse_ss,
    "vmess://": parse_vmess,
    "trojan://": parse_trojan,
    "vless://": parse_vless,
    "hysteria2://": parse_hysteria2,
    "hy2://": parse_hysteria2,
}


def parse_nodes(lines: list) -> list:
    nodes = []
    idx = 1
    for line in lines:
        for prefix, parser_fn in PARSERS.items():
            if line.startswith(prefix):
                try:
                    node = parser_fn(line, idx)
                except Exception:
                    node = None
                if node:
                    nodes.append(node)
                    idx += 1
                break
    return nodes


# ---------------------------------------------------------------------------
# 3. 展示 + 选择
# ---------------------------------------------------------------------------

def display_nodes(nodes: list) -> None:
    print("\n可用节点：")
    for i, node in enumerate(nodes, 1):
        ob = node.outbound
        print(f"  [{i}] {node.tag}  ({ob['type']}  {ob.get('server')}:{ob.get('server_port')})")
    print()


def select_node(nodes: list) -> Node:
    while True:
        choice = input(f"请选择节点 (1-{len(nodes)}): ").strip()
        if choice.isdigit() and 1 <= int(choice) <= len(nodes):
            return nodes[int(choice) - 1]
        print("输入无效，请重新输入。")


# ---------------------------------------------------------------------------
# 4. 生成 sing-box config.json
# ---------------------------------------------------------------------------

def build_singbox_config(node: Node, mixed_port: int = 1087) -> dict:
    return {
        "log": {"level": "info", "timestamp": True},
        "inbounds": [
            {
                "type": "mixed",
                "tag": "mixed-in",
                "listen": "127.0.0.1",
                "listen_port": mixed_port,
            }
        ],
        "outbounds": [
            node.outbound,
            {"type": "direct", "tag": "direct"},
            {"type": "block", "tag": "block"},
        ],
        "route": {
            "rules": [
                {"ip_is_private": True, "outbound": "direct"}
            ],
            "final": node.tag,
        },
    }


# ---------------------------------------------------------------------------
# 5. 启动 sing-box
# ---------------------------------------------------------------------------

def run_singbox(config_path: str, binary: str = "sing-box") -> None:
    cmd = [binary, "run", "-c", config_path]
    print(f"\n启动命令: {' '.join(cmd)}")
    try:
        subprocess.run(cmd, check=True)
    except FileNotFoundError:
        print(
            f"未找到可执行文件 '{binary}'，请确认 sing-box 已安装并在 PATH 中，"
            f"或使用 --bin 参数指定路径。"
        )
        sys.exit(1)
    except subprocess.CalledProcessError as e:
        print(f"sing-box 退出，返回码 {e.returncode}")
        sys.exit(e.returncode)
    except KeyboardInterrupt:
        print("\n已停止。")


# ---------------------------------------------------------------------------
# 主流程
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="订阅转 sing-box 配置并启动")
    parser.add_argument("url", nargs="?", help="订阅链接（省略时会尝试读取已保存的链接，否则交互式输入）")
    parser.add_argument("-u", "--set-url", help="更新并保存订阅链接，然后使用它")
    parser.add_argument("--url-file", default=DEFAULT_URL_FILE, help=f"保存订阅链接的文件路径（默认: {DEFAULT_URL_FILE}）")
    parser.add_argument("-o", "--output", default="config.json", help="生成的配置文件路径")
    parser.add_argument("-p", "--port", type=int, default=1087, help="本地监听端口（mixed 入站，SOCKS5+HTTP）")
    parser.add_argument("--bin", default="sing-box", help="sing-box 可执行文件路径")
    parser.add_argument("--no-run", action="store_true", help="仅生成配置，不启动 sing-box")
    args = parser.parse_args()

    url = resolve_url(args)
    if not url:
        print("未提供订阅链接。")
        sys.exit(1)

    print("正在下载订阅...")
    try:
        content = fetch_subscription(url)
    except Exception as e:
        print(f"下载订阅失败: {e}")
        sys.exit(1)

    print("正在解析节点...")
    lines = decode_subscription(content)
    nodes = parse_nodes(lines)

    if not nodes:
        print(
            "未解析到任何节点，请检查订阅内容是否为支持的格式"
            "（ss / vmess / trojan / vless / hysteria2）。"
        )
        sys.exit(1)

    display_nodes(nodes)
    node = select_node(nodes)

    config = build_singbox_config(node, mixed_port=args.port)
    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(config, f, ensure_ascii=False, indent=2)
    print(f"\n已生成配置文件: {args.output}")
    print(f"本地代理地址: 127.0.0.1:{args.port} (SOCKS5 / HTTP)")

    if not args.no_run:
        run_singbox(args.output, binary=args.bin)


if __name__ == "__main__":
    main()
