load_module() {
#    t1=$(gdate +%s%3N)
    source ${HOME}/.dotfiles/modules/${1}/load.*sh
#    t2=$(gdate +%s%3N)
#    echo ${1} $((t2 - t1)) ms
}

load_module proxy