source ${HOME}/.dotfiles/modules/util.bash

module_link "${HOME}/.dotfiles/modules/nvim/config" "${HOME}/.config/nvim"

echo "export EDITOR='nvim'" >> ${HOME}/.zshenv
