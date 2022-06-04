function dotfiles() {
    if [[ $1 == "backup" ]] ; then

        # update dotfile list
        source ~/.dotfiles/dotfile_list.sh
        
        # cp all dot files from ~/ to ~/.dotfiles
        rsync -av --delete ${DOTFILES[@]/./~\/.} ~/.dotfiles
        
        # use git to backup to remote repository
        cd ~/.dotfiles
        git add --all
        if [[ $# == 2 ]] ; then
            git commit -m "$2"
        else
            git commit -m "no commit message"
        fi
        git push
        cd -

    elif [[ $1 == "recover" ]] ; then

        cd ~/.dotfiles

        # update dotfile list
        source ~/.dotfiles/dotfile_list.sh

        # cp all dot files from ~/.dotfiles to ~/
        rsync -Pavz --delete ${DOTFILES[@]} ~/

        cd -

    elif [[ $1 == "remote_sync" ]] ; then

        cd ~/.dotfiles

        # update dotfile list
        source ~/.dotfiles/dotfile_list.sh

        # cp all dot files from ~/.dotfiles to a remove server
        rsync -Pavz --delete ${DOTFILES[@]} ${2}:

        cd -

    fi
}

# zsh autocompletion
if [[ $SHELL == "/bin/zsh" ]] ; then
    function _dotfiles() {
        compadd backup recover remote_sync
    }
    compdef _dotfiles dotfiles
fi

