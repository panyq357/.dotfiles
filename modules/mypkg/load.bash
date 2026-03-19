mypkg() {
	echo $1
    if [[ "${1}" == "install" ]]; then
        bash ${HOME}/.dotfiles/modules/mypkg/${2}/install.bash
    elif [[ ${1} == "uninstall" ]]; then
        bash ${HOME}/.dotfiles/modules/mypkg/${2}/uninstall.bash
    fi

}
