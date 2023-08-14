bindkey -e
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt share_history

export TERM="xterm-256color"
export LANG="en_US.UTF-8"
export EDITOR="/opt/homebrew/bin/vim"

# Make tree display chinese charactor.
alias tree="tree -NC" 

alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"

# Exclude ._* AppleDouble files and .DS_Store files.
alias tar="tar --no-mac-metadata --exclude '**/.DS_Store'"

if [[ "$PATH" != *"homebrew"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Proxy shortcut function.
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

