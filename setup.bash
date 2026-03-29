arr=(
    zsh
    tmux
    git
    conda
    nvim
    r_
)

for x in ${arr[@]}; do
    bash ${HOME}/.dotfiles/modules/${x}/setup.bash
done
