cd ${HOME}/.dotfiles/modules/mypkg/packages

if [[ $(uname) == "Linux" && $(arch) == "x86_64" ]]; then
    download_link="https://github.com/broadinstitute/gatk/releases/download/4.7.0.0/gatk-4.7.0.0.zip"
else
    echo "Unparsable platform: uname=${uname}, arch=${arch}." >&2
    return 1
fi

wget ${download_link}

unzip $(basename ${download_link})

uncompressed_dir=$(realpath $(basename ${download_link} '.zip'))

ln -s $uncompressed_dir/gatk "$HOME/.local/bin/gatk"

rm $(basename ${download_link})
