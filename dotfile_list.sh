DOTFILES=(
    .vimrc
    .condarc
    .Rprofile
    .tmux.conf
)
if [[ $SHELL == "/bin/zsh" ]] ; then
    DOTFILES+=(.zshrc)
fi
