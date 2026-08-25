cd ${HOME}/.dotfiles/modules/mypkg/packages

if [[ $(uname) == "Linux" && $(arch) == "x86_64" ]]; then
    download_link="https://github.com/SagerNet/sing-box/releases/download/v1.13.18/sing-box-1.13.18-linux-amd64.tar.gz"
else
    echo "Unparsable platform: uname=${uname}, arch=${arch}." >&2
    return 1
fi

wget ${download_link}

tar -xf $(basename ${download_link})

uncompressed_dir=$(realpath $(basename ${download_link} '.tar.gz'))

ln -s "${uncompressed_dir}/sing-box" $HOME/.local/bin/sing-box

rm $(basename ${download_link})
