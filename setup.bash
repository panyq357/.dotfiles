link_arr=(
    conda 
    git
    nvim
    r_
    tmux
    zsh
)

for x in ${link_arr[@]}; do
    bash ${HOME}/.dotfiles/modules/${x}/setup.bash
done
