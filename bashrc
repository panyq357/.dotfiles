# ---------- Prompt -----------------------------------------------------------
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
# ---------- Prompt End -------------------------------------------------------

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
    "${HOME}/Tools/bwa"
    "${HOME}/Tools/bwa/bwakit"
    "${HOME}/Tools/ensembl-vep"
    "${HOME}/Tools/bowtie2"
    "${HOME}/Tools/bowtie2/scripts"
    "${HOME}/Tools/minimap2"
    "${HOME}/Tools/sratoolkit/bin"
    "${HOME}/Tools/MCScanX"
    "${HOME}/Tools/MCScanX/downstream_analyses"
    "${HOME}/Tools/plink"
    "${HOME}/Tools/LDBlockShow/bin"
)

for path in ${path_arr[@]} ; do
    if [[ "$PATH" != *"$path"* ]]; then
        export PATH="${path}:${PATH}"
    fi
done
# ---------- PATH End ---------------------------------------------------------

# ---------- Proxy ------------------------------------------------------------
# Proxy shortcut function.
HOSTIP=$(ip route | grep default | awk '{print $3}')
PROXY="http://${HOSTIP}:10809"
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/panyq/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/panyq/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/panyq/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/panyq/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export MAMBA_NO_BANNER=1
# ---------- Conda End --------------------------------------------------------

# ----------- Perl ------------------------------------------------------------
PATH="/home/panyq/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/panyq/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/panyq/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/panyq/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/panyq/perl5"; export PERL_MM_OPT;

# ----------- Perl End --------------------------------------------------------

# less source highlight
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

export EDITOR="vim"
export BROWSER='/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'

