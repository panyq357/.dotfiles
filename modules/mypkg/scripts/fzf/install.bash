cd ${HOME}/.dotfiles/modules/mypkg/packages

os=$(uname)
arch=$(arch)

version=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | grep '"tag_name"' | sed -E 's/.*"tag_name"[^"]+"v([^"]+)".*/\1/')

if [[ "${os}" == "Linux" && "${arch}" == "x86_64" ]]; then
  platform="linux_amd64"
elif [[ "${os}" == "Darwin" && "${arch}" == "arm64" ]]; then
  platform="darwin_arm64"
else
  echo "No install method for uname: ${os}, arch: ${arch}." >&2
  return 1
fi

wget "https://github.com/junegunn/fzf/releases/download/v${version}/fzf-${version}-${platform}.tar.gz"

mkdir fzf-${version}-${platform}
tar -xf "fzf-${version}-${platform}.tar.gz" -C fzf-${version}-${platform}
mkdir -p ${HOME}/.local/bin
ln -s $(realpath fzf-${version}-${platform}/fzf) $HOME/.local/bin/fzf
rm "fzf-${version}-${platform}.tar.gz"
