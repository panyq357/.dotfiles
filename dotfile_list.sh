DOTFILES=(
    .vimrc
    .Rprofile
    .tmux.conf
)
if [[ $SHELL == "/bin/zsh" ]] ; then
    DOTFILES+=(.zshrc)
fi
