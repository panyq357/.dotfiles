mypkg() {

    mkdir -p ${HOME}/.dotfiles/modules/mypkg/packages/

    if [[ "${1}" == "install" ]]; then
        bash ${HOME}/.dotfiles/modules/mypkg/${2}/install.bash
    elif [[ ${1} == "uninstall" ]]; then
        bash ${HOME}/.dotfiles/modules/mypkg/${2}/uninstall.bash
    fi

}
