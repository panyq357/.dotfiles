zstyle :compinstall filename "${HOME}/.zshrc"               #
autoload -Uz compinit                                       # lines added by compinstall
compinit                                                    #

bindkey -e                                                  # use EMACS key binding
setopt share_history

autoload edit-command-line                                  #
zle -N edit-command-line                                    # use CTRL-X_CTRL-E to edit command in $EDITOR
bindkey '^x^e' edit-command-line                            #

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

export TERM="xterm-256color"
export LANG="en_US.UTF-8"
export EDITOR="/opt/homebrew/bin/vim"

alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias tree="tree -NC"                                       # Make tree display chinese charactor.
alias tar="tar --no-mac-metadata --exclude '**/.DS_Store'"  # Exclude ._* AppleDouble files and .DS_Store files.

# ---------- zplug & plugin management ----------------------------------------
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug load
# ---------- zplug & plugin management End ------------------------------------

# ---------- Homebrew ---------------------------------------------------------
if [[ "$PATH" != *"homebrew"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# ---------- Homebrew End -----------------------------------------------------

# ---------- PATH -------------------------------------------------------------
path_arr=(
    "${HOME}/.local/bin"
)

for p in ${path_arr[@]} ; do  # lower case "path" is a reserved variable, don't use it.
    if [[ "$PATH" != *"$path"* ]]; then
        export PATH="${p}:${PATH}"
    fi
done

# ---------- PATH End ---------------------------------------------------------

# ---------- Proxy ------------------------------------------------------------
PROXY="http://127.0.0.1:1087"
function proxy() {
    if [[ $1 == "off" ]] ; then
        unset no_proxy
        unset http_proxy
        unset https_proxy
        unset ftp_proxy
        unset rsync_proxy
        echo -e "PROXY OFF"
    elif [[ $1 == "on" ]] ; then
        export no_proxy="localhost,127.0.0.1"
        export http_proxy=${PROXY}
        export https_proxy=${PROXY}
        export ftp_proxy=${PROXY}
        export rsync_proxy=${PROXY}
        echo -e "PROXY ON"
    fi
}
function _proxy() {
    compadd on off
}
compdef _proxy proxy
# ---------- Proxy End --------------------------------------------------------

