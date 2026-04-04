cd ${HOME}/.dotfiles/modules/mypkg/packages

os=$(uname)
arch=$(arch)

version=$(curl -s https://api.github.com/repos/fatedier/frp/releases/latest | grep '"tag_name"' | sed -E 's/.*"tag_name"[^"]+"v([^"]+)".*/\1/')

if [[ "${os}" == "Linux" && "${arch}" == "x86_64" ]]; then
  wget "https://github.com/fatedier/frp/releases/download/v${version}/frp_${version}_linux_amd64.tar.gz"
else
  echo "No install method for uname: ${os}, arch: ${arch}."
fi

tar -xf "frp_${version}_linux_amd64.tar.gz"
ln -s $(realpath "frp_${version}_linux_amd64/frpc") $HOME/.local/bin/frpc
ln -s $(realpath "frp_${version}_linux_amd64/frps") $HOME/.local/bin/frps
