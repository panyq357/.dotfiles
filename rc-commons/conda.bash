CONDA_DIR=${HOME}/tools/miniforge3
if [ -e ${CONDA_DIR} ] ; then
    function ca() {
        source ${CONDA_DIR}/bin/activate $1
    }
fi
export MAMBA_NO_BANNER=1
