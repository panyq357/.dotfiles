export PYENV_ROOT="$HOME/.pyenv"

if [ -d $PYENV_ROOT ] ; then
    # Lazy loading pyenv.
    pyenv() {
        [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        # After loading above two, pyenv command have been replaced.
        pyenv $@
    }
fi

