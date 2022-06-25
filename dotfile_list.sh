DOTFILES=(
    .vimrc
    .Rprofile
    .tmux.conf
    .condarc
)
if [[ $SHELL == "/bin/zsh" ]] ; then
    DOTFILES+=(.zshrc)
fi
