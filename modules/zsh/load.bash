# Enable zsh auto completion.
autoload -Uz compinit && compinit

# Enable zsh share history across multiple sessions.
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Reload history when first pressing ctrl-P
function _history_up_with_reload() {
  if [[ $_history_reloaded != 1 ]]; then
    fc -R
    # Use this flag variable to store state.
    _history_reloaded=1
  fi
  zle up-history
}
zle -N _history_up_with_reload
bindkey '^P' _history_up_with_reload

# Reset flag after pressing enter
function _reset_history_reload() {
  _history_reloaded=0
  zle accept-line
}
zle -N _reset_history_reload
bindkey '^M' _reset_history_reload
