# ---------- Prompt -----------------------------------------------------------
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
# ---------- Prompt End -------------------------------------------------------

export EDITOR=nvim
export BROWSER=msedge

# ---------- Alias ------------------------------------------------------------
alias ls="ls --color=auto"
alias ll="ls -lh --color"
alias grep="grep --color"
alias cp='cp -i'
alias mv='mv -i'
alias ipython="python3 -m IPython"
# ---------- Alias End --------------------------------------------------------

# ---------- PATH -------------------------------------------------------------
path_arr=(
    "${HOME}/tools/bin"

    "${HOME}/tools/nvim-linux-x86_64/bin"
    "${HOME}/tools/STAR_2.7.11b/Linux_x86_64_static"
    "${HOME}/tools/node-v22.18.0-linux-x64/bin"
    "${HOME}/tools/meme-5.5.8/bin"
    "${HOME}/tools/meme-5.5.8/libexec/meme-5.5.8"
    "${HOME}/tools/annovar"
    "${HOME}/tools/apache-maven-3.9.11/bin"
    "${HOME}/tools/jdt-language-server-1.49.0/bin"
    "${HOME}/tools/sratoolkit.3.2.1-ubuntu64/bin"
    "${HOME}/tools/obsutil_linux_amd64_5.7.3"
    "${HOME}/tools/minimap2-2.30_x64-linux"

    "${HOME}/repos/ensembl-vep"
    "${HOME}/repos/tassel-5-standalone"

)

for p in ${path_arr[@]} ; do  # lower case "path" is a reserved variable, don't use it.
    if [[ "$PATH" != *"$p"* ]]; then
        export PATH="${p}:${PATH}"
    fi
done
# ---------- PATH End ---------------------------------------------------------

# ---------- Proxy ------------------------------------------------------------
# Proxy shortcut function.
HOSTIP=127.0.0.1
PROXY="http://${HOSTIP}:1087"
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
# ---------- Proxy End --------------------------------------------------------

# ---------- Conda ------------------------------------------------------------
CONDA_DIR=${HOME}/Tools/miniforge3
if [ -e ${CONDA_DIR} ] ; then
    function ca() {
        source ${CONDA_DIR}/bin/activate $1
    }
fi
export MAMBA_NO_BANNER=1
# ---------- Conda End --------------------------------------------------------

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
    command nnn "$@" -A

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
export NNN_OPENER=wsl-open
export NNN_TRASH=1
# ---------- NNN End ----------------------------------------------------------

# ---------- Perl -------------------------------------------------------------
if [ -d ${HOME}/perl5/lib/perl5 ] ; then
    eval "$(perl -I${HOME}/perl5/lib/perl5 -Mlocal::lib)"
fi
# ---------- Perl End ---------------------------------------------------------

# ---------- FZF --------------------------------------------------------------
ff () {
    find $1 | fzf
}
# ---------- FZF End ----------------------------------------------------------

# ---------- pyenv ------------------------------------------------------------
if [ -d ${HOME}/.pyenv ] ; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Bind r to radian in pyenv global version.
alias r="$(pyenv which radian) --restore-data"
# ---------- pyenv End --------------------------------------------------------

# ---------- rbenv ------------------------------------------------------------
if [ -d ${HOME}/.rbenv ] ; then
    eval "$(~/.rbenv/bin/rbenv init - bash)"
fi
# ---------- rbenv End --------------------------------------------------------

# ---------- vifm -------------------------------------------------------------
vicd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}
# ---------- vifm End ---------------------------------------------------------

# ---------- Java -------------------------------------------------------------
export JAVA_HOME="/usr/lib/jvm/jdk-21.0.8-oracle-x64"
