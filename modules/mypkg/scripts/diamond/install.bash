cd ${HOME}/.dotfiles/modules/mypkg/packages

if [[ $(uname) == "Linux" && $(arch) == "x86_64" ]]; then
    download_link="http://github.com/bbuchfink/diamond/releases/download/v2.2.5/diamond-linux64.tar.gz"
else
    echo "Unparsable platform: uname=${uname}, arch=${arch}." >&2
    return 1
fi

wget ${download_link}

uncompressed_dir_basename=$(basename ${download_link} '.tar.gz')

mkdir $uncompressed_dir_basename

tar -xf $(basename ${download_link}) -C $uncompressed_dir_basename

uncompressed_dir=$(realpath $uncompressed_dir_basename)

ln -s "${uncompressed_dir}/diamond" $HOME/.local/bin/diamond

rm $(basename ${download_link})
