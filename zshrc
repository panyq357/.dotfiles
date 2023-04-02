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

# Combine source-highlight with less
# ref: https://superuser.com/a/71593
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Exclude ._* AppleDouble files and .DS_Store files.
alias tar="tar --no-mac-metadata --exclude '**/.DS_Store'"

if [[ "$PATH" != *"homebrew"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ "$PATH" != *"pyenv"* ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
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

# Function for re-mount NTFS external hard drive.
function mmount() {
    NAME=$1
    identifier=`diskutil list | grep -n ${NAME} | sed -E 's/.*(disk[0-9]+s[0-9]+).*/\\1/'`
    new_dir="/Volumes/${NAME}"
    sudo diskutil umount ${identifier} > /dev/null
    sudo mkdir ${new_dir}
    sudo mount_ntfs /dev/${identifier} ${new_dir}
}
function _mmount() {
    compadd BLACK WHITE RC100
}
compdef _mmount mmount

# pyenv related commands.
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# conda related commands.
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/panyq/Tools/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/panyq/Tools/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/panyq/Tools/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/panyq/Tools/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<
CONDA_DIR="/Users/panyq/Tools/miniconda3"
function ca() {
    source ${CONDA_DIR}/bin/activate $1
}
function _ca() {
    compadd 
}
compdef _ca ca
export MAMBA_NO_BANNER=1

# chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3 # run chruby to see actual version

