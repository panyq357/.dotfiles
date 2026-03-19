conda_dir="${HOME}/.dotfiles/modules/mypkg/packages/miniforge3"

if ! [ -d ${conda_dir} ]; then
    echo "conda not found in ${conda_dir}, install by: 'mypkg install miniforge3'."
    return 1
fi

function ca() {
    source ${conda_dir}/bin/activate $1
}

export MAMBA_NO_BANNER=1
