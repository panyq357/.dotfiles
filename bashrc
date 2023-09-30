# ---------- Prompt -----------------------------------------------------------
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
# ---------- Prompt End -------------------------------------------------------

export EDITOR=vim

# ---------- Alias ------------------------------------------------------------
alias ls="ls --color=auto"
alias ll="ls -lh --color"
alias grep="grep --color"
alias cp='cp -i'
alias mv='mv -i'
alias jl="jupyter lab --port 10000 --no-browser --ip 192.168.31.100"
# ---------- Alias End --------------------------------------------------------

# ---------- PATH -------------------------------------------------------------
path_arr=(
    "${HOME}/.local/bin"
    "${HOME}/Tools/bin"
    "${HOME}/Tools/ensembl-vep"
    "${HOME}/Tools/ucsc-tools"
    "${HOME}/Tools/LDBlockShow/bin"
)

for p in ${path_arr[@]} ; do  # lower case "path" is a reserved variable, don't use it.
    if [[ "$PATH" != *"$p"* ]]; then
        export PATH="${p}:${PATH}"
    fi
done
# ---------- PATH End ---------------------------------------------------------

# ---------- Proxy ------------------------------------------------------------
# Proxy shortcut function.
HOSTIP=localhost
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
CONDA_DIR=${HOME}/Tools/miniconda3
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
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
# ---------- NNN End ----------------------------------------------------------

# ---------- Perl -------------------------------------------------------------
eval "$(perl -I${HOME}/perl5/lib/perl5 -Mlocal::lib)"
# ---------- Perl End ---------------------------------------------------------

