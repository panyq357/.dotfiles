# ---------- Homebrew ---------------------------------------------------------
if [[ -e "/opt/homebrew" ]] && [[ *"$PATH"* != *"/opt/homebrew/bin"* ]] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# ---------- Homebrew End -----------------------------------------------------

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
export EDITOR="/opt/homebrew/bin/vim"                       # use homebrew vim (not /usr/bin/vim)

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


# ---------- PATH -------------------------------------------------------------
path_arr=(
    "${HOME}/.local/bin"
    "${HOME}/Tools/bin"
)

for p in ${path_arr[@]} ; do  # lower case "path" is a reserved variable, don't use it.
    if [[ "$PATH" != *"$path"* ]]; then
        export PATH="${p}:${PATH}"
    fi
done

# ---------- PATH End ---------------------------------------------------------

# ---------- Proxy ------------------------------------------------------------
proxy_url="http://127.0.0.1:1087"
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
        export http_proxy=${proxy_url}
        export https_proxy=${proxy_url}
        export ftp_proxy=${proxy_url}
        export rsync_proxy=${proxy_url}
        echo -e "PROXY ON"
    fi
}
function _proxy() {
    compadd on off
}
compdef _proxy proxy
# ---------- Proxy End --------------------------------------------------------

# ---------- Conda ------------------------------------------------------------
conda_dir="${HOME}/Tools/miniforge3"
function ca() {
    source ${conda_dir}/bin/activate $1
}
# ---------- Conda End ---------------------------------------------------------

# ---------- NNN --------------------------------------------------------------
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
# ---------- NNN End ----------------------------------------------------------
