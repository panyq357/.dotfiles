# See: <https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration>

if command -v fzf >/dev/null 2>&1; then
    if [ -n "$BASH_VERSION" ]; then
        eval "$(fzf --bash)"
    elif [ -n "$ZSH_VERSION" ]; then
        source <(fzf --zsh)
    fi
fi
