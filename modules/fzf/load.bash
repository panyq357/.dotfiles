# ref: https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration

if ! command -v fzf >/dev/null 2>&1; then
    echo "fzf not found, please install."
    return 1
fi

if [ -n "$BASH_VERSION" ]; then
    eval "`fzf --bash`"
elif [ -n "$ZSH_VERSION" ]; then
    source <(fzf --zsh)
fi

# Reload history when first pressing ctrl-P
function _fzf_history_with_reload() {
  if [[ $_history_reloaded != 1 ]]; then
    fc -R
    # Use this flag variable to store state.
    _history_reloaded=1
  fi
  zle fzf-history-widget
}
zle -N _fzf_history_with_reload
bindkey '^R' _fzf_history_with_reload

# Check ~/.dotfiles/modules/zsh/load.bash for related settings:
#
#   - Press Ctrl-P to trigger fc -R.
#   - Press return to reset _history_reloaded
