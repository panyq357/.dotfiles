if ! command -v direnv >/dev/null 2>&1; then
    echo "direnv not found, install with 'mypkg install direnv'."
    return 1
fi

eval "$(direnv hook $SHELL)"
