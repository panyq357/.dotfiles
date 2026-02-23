module_link() {
    source "${HOME}/.dotfiles/modules/${1}/link.bash"
    if [[ -L $to || -e $to ]]; then
        echo "${to} exists, skip."
    else
        ln -s $from $to
    fi
}

link_arr=(
    conda 
    git
    nvim
    r_
    tmux
    zsh
)

for x in ${link_arr[@]}; do
    module_link $x
done

source "${HOME}/.dotfiles/modules/path_/install.bash"
