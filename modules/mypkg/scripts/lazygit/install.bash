cd ${HOME}/.dotfiles/modules/mypkg/packages

if [[ $(uname) == "Linux" && $(arch) == "x86_64" ]]; then
    download_link="https://github.com/jesseduffield/lazygit/releases/download/v0.64.1/lazygit_0.64.1_linux_x86_64.tar.gz"
else
    echo "Unparsable platform: uname=${uname}, arch=${arch}." >&2
    return 1
fi

wget ${download_link}

uncompressed_dir_basename=$(basename ${download_link} '.tar.gz')

mkdir $uncompressed_dir_basename

tar -xf $(basename ${download_link}) -C $uncompressed_dir_basename

uncompressed_dir=$(realpath $uncompressed_dir_basename)

ln -s "${uncompressed_dir}/lazygit" $HOME/.local/bin/lazygit

rm $(basename ${download_link})
