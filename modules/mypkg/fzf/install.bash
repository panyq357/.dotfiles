cd ${HOME}/.dotfiles/modules/mypkg/packages

os=$(uname)
arch=$(arch)

version=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | grep '"tag_name"' | sed -E 's/.*"tag_name"[^"]+"v([^"]+)".*/\1/')

if [[ "${os}" == "Linux" && "${arch}" == "x86_64" ]]; then
  wget "https://github.com/junegunn/fzf/releases/download/v${version}/fzf-${version}-linux_amd64.tar.gz"
elif [[ "${os}" == "Darwin" && "${arch}" == "arm64" ]]; then
  wget "https://github.com/junegunn/fzf/releases/download/v${version}/fzf-${version}-darwin_arm64.tar.gz"
else
  echo "No install method for uname: ${os}, arch: ${arch}."
fi

mkdir fzf-${version}-linux_amd64
tar -xf "fzf-${version}-linux_amd64.tar.gz" -C fzf-${version}-linux_amd64
mkdir -p ${HOME}/.local/bin
ln -s $(realpath fzf-${version}-linux_amd64/fzf) $HOME/.local/bin/fzf
rm "fzf-${version}-linux_amd64.tar.gz"
