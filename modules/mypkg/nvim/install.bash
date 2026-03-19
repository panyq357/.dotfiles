cd ${HOME}/.dotfiles/modules/mypkg/packages

os=$(uname)
arch=$(arch)

if [[ "$(uname)" == "Linux" && "${arch}" == "x86_64" ]]; then
  wget "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
  tar -xf nvim-linux-x86_64.tar.gz
  ln -s $(realpath nvim-linux-x86_64/bin/nvim) ${HOME}/.local/bin/nvim
  rm nvim-linux-x86_64.tar.gz
elif [[ "$(uname)" == "Darwin" && "${arch}" == "arm64" ]]; then
  url="https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz"
  tar -xf nvim-macos-arm64.tar.gz
  ln -s $(realpath nvim-macos-arm64/bin/nvim) ${HOME}/.local/bin/nvim
  rm nvim-macos-arm64.tar.gz
else
  echo "No install method for uname: $(uname), arch: ${arch}."
fi
