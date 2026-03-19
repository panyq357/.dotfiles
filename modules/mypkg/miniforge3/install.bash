cd ${HOME}/.dotfiles/modules/mypkg/packages

wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(arch).sh"
bash Miniforge3-$(uname)-$(arch).sh -p ./miniforge3 -b
rm Miniforge3-$(uname)-$(arch).sh
