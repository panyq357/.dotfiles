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
# ---------- Proxy End --------------------------------------------------------

# ---------- Conda ------------------------------------------------------------
CONDA_DIR="${HOME}/Tools/mambaforge"
function ca() {
    source ${CONDA_DIR}/bin/activate $1
}
export MAMBA_NO_BANNER=1
# ---------- Conda ------------------------------------------------------------

# less source highlight
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

export EDITOR="vim"
