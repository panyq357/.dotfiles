module_link() {
    source "${HOME}/.dotfiles/modules/${1}/link.bash"
    if [[ -L $to || -e $to ]]; then
        echo "Skip: ${to} exists"
    else
        echo "Soft link: ${from} -> ${to}"
        ln -s $from $to
    fi
}

link_arr=(
    conda 
    git
    nvim
    r_
    tmux
)

for x in ${link_arr[@]}; do
    module_link $x
done


from=${HOME}/.dotfiles/modules/zsh/zshrc
to="${HOME}/.zshrc"

if [[ ! -e $to ]]; then
    echo "Copy: ${from} -> ${to}"
    cp $from $to
else
    echo "Skip: ${to} exists"
fi

from=${HOME}/.dotfiles/modules/zsh/zshenv
to="${HOME}/.zshenv"

if [[ ! -e $to ]]; then
    echo "Copy: ${from} -> ${to}"
    cp $from $to
else
    echo "Skip: ${to} exists"
fi
