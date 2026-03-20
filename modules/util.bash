module_link() {
    if [[ -L $2 || -e $2 ]]; then
        echo "Skip: ${2} exists"
    else
        echo "Soft link: ${1} -> ${2}"
        ln -s $1 $2
    fi
}

module_copy() {
    if [[ -L $2 || -e $2 ]]; then
        echo "Skip: ${2} exists"
    else
        echo "Copy: ${1} -> ${2}"
        cp $1 $2
    fi
}
