cd ${HOME}/.dotfiles/modules/mypkg/packages

if [[ $(uname) == "Linux" && $(arch) == "x86_64" ]]; then
    download_link="https://github.com/samtools/bcftools/releases/download/1.24/bcftools-1.24.tar.bz2"
else
    echo "Unparsable platform: uname=${uname}, arch=${arch}." >&2
    return 1
fi

wget ${download_link}

tar -xf $(basename ${download_link})

uncompressed_dir=$(realpath $(basename ${download_link} '.tar.bz2'))

cd "$uncompressed_dir"
./configure --prefix="$(realpath .)"
make
make install
cd -

echo "Bcftools 1.24 installed, add following to PATH:"
echo
echo "  /home/panyq/.dotfiles/modules/mypkg/packages/bcftools-1.24/bin"
echo

rm $(basename ${download_link})
