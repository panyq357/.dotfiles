conda_dir="${HOME}/tools/miniforge3"
if ! [ -d ${conda_dir} ]; then
    echo "conda not found in ${conda_dir}, please install."
    return 1
fi

function ca() {
    source ${conda_dir}/bin/activate $1
}
export MAMBA_NO_BANNER=1
