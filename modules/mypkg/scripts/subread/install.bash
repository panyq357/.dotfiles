cd ${HOME}/.dotfiles/modules/mypkg/packages

if [[ $(uname) == "Linux" && $(arch) == "x86_64" ]]; then
    download_link="https://sourceforge.net/projects/subread/files/subread-2.1.1/subread-2.1.1-Linux-x86_64.tar.gz"
else
    echo "Unparsable platform: uname=${uname}, arch=${arch}." >&2
    return 1
fi

wget ${download_link}

tar -xf $(basename ${download_link})

uncompressed_dir=$(realpath $(basename ${download_link} '.tar.gz'))

echo "Subread 2.1.1 installed, add following to PATH:"
echo
echo "  /home/panyq/.dotfiles/modules/mypkg/packages/subread-2.1.1-Linux-x86_64/bin"
echo "  /home/panyq/.dotfiles/modules/mypkg/packages/subread-2.1.1-Linux-x86_64/bin/utilities"
echo

rm $(basename ${download_link})
