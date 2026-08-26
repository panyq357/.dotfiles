arr=(
    bash
    nvim
    git
)

for x in ${arr[@]}; do
    bash ${HOME}/.dotfiles/modules/${x}/setup.git-bash.bash
done
