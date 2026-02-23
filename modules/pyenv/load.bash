export PYENV_ROOT="$HOME/.pyenv"

if ! [ -d $PYENV_ROOT ] ; then
    echo "~/.pyenv not found, please install."
    return 1
fi

export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

# Lazy loading pyenv.
pyenv() {
    unset -f pyenv
    eval "`pyenv init -`"
    command pyenv $@
}
