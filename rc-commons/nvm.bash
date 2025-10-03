export NVM_DIR="$HOME/.nvm"

if [ -d "$NVM_DIR" ]; then

    # Lazy-load nvm.
    nvm() {
        # Load nvm script.
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        # Load nvm bash completion.
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
        # After loading above two, nvm command have been replaced.
        nvm "$@"
    }
fi
