cd ${HOME}/.dotfiles/modules/mypkg/packages

os=$(uname | tr "[:upper:]" "[:lower:]")
arch=$(arch | tr "[:upper:]" "[:lower:]")

version=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | sed -E 's/.*"tag_name"[^"]+"v([^"]+)".*/\1/')

wget "https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_${os}_${arch}.tar.gz"

mkdir lazygit_${version}_${os}_${arch}
tar -xf "lazygit_${version}_${os}_${arch}.tar.gz" -C lazygit_${version}_${os}_${arch}
rm "lazygit_${version}_${os}_${arch}.tar.gz"
ln -s $(realpath lazygit_${version}_${os}_${arch}/lazygit) $HOME/.local/bin/lazygit
