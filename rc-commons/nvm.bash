export NVM_DIR="$HOME/.nvm"

if [ -d "$NVM_DIR" ]; then

    # Load nvm.
    load_nvm() {
        # Load nvm script.
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        # Load nvm bash completion.
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    }

    nvm_default="$NVM_DIR/alias/default"

    if [ -s "$nvm_default" ]; then

        # A shortcut for fast prepend default Node.js `bin/`
        default_content=$(cat $nvm_default | tr -d ' \n')
        if [[ "$default_content" == "lts/*" ]]; then
            node_version=$(
                ls "$NVM_DIR/versions/node/" \
                | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' \
                | sort -V \
                | while read -r x; do
                      major=$(echo $x | cut -d. -f1 | tr -d 'v')
                      if [ $((major % 2)) -eq 0 ]; then
                          echo $x
                      fi
                  done \
                | tail -n 1
            )
        elif [[ "$default_content" == "node" ]]; then
            node_version=$(
                ls "$NVM_DIR/versions/node/" \
                | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' \
                | sort -V \
                | tail -n 1
            )
        fi
        node_dir="$NVM_DIR/versions/node/$node_version/bin"
        export PATH="$node_dir:$PATH"

        # Lazy loading nvm
        nvm() {
            load_nvm
            nvm "$@"
        }
    else
        # Fall back to default nvm loading
        load_nvm
    fi
fi
