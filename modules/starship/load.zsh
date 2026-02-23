if ! command -v starship >/dev/null 2>&1; then
    echo "starship not found, please install."
    return 1
fi

eval "`starship init zsh`"
