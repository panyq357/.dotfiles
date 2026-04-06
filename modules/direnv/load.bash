if ! command -v direnv >/dev/null 2>&1; then
    echo "direnv not found, install with following:"
    echo ""
    echo "    export bin_path=~/.local/bin"
    echo "    curl -sfL https://direnv.net/install.sh | bash"
    echo ""
    return 1
fi

eval "$(direnv hook $SHELL)"
