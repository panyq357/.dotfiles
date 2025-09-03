if [ -d ${HOME}/.pyenv ] ; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Bind r to radian in pyenv global version.
alias r="$(pyenv which radian) --restore-data"
