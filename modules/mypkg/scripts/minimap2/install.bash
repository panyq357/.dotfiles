cd ${HOME}/.dotfiles/modules/mypkg/packages

if [[ $(uname) == "Linux" && $(arch) == "x86_64" ]]; then
    download_link="https://github.com/lh3/minimap2/releases/download/v2.31/minimap2-2.31_x64-linux.tar.bz2"
else
    echo "Unparsable platform: uname=${uname}, arch=${arch}." >&2
    return 1
fi

wget ${download_link}

tar -xf $(basename ${download_link})

uncompressed_dir=$(realpath $(basename ${download_link} '.tar.bz2'))

ln -s $uncompressed_dir/minimap2 $HOME/.local/bin/minimap2
ln -s $uncompressed_dir/k8 $HOME/.local/bin/k8
ln -s $uncompressed_dir/paftools.js $HOME/.local/bin/paftools.js

rm $(basename ${download_link})
