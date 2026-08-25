cd ${HOME}/.dotfiles/modules/mypkg/packages

if ! command -v cpanm >/dev/null 2>&1; then
    echo "cpanm not found, please install it first." >&2
    echo
    echo "    cd ~/.local/bin; curl -L https://cpanmin.us/ -o cpanm; chmod u+x cpanm; cd -"
    echo
    exit 1
fi

cpanm_modules=(Archive::Zip DBI Module::Build LWP::Simple List::MoreUtils)
apt_packages=(libbz2-dev liblzma-dev zlib1g-dev)

missing_cpanm_modules=()
for m in "${cpanm_modules[@]}"; do
    if ! perl -M"$m" -e 1 >/dev/null 2>&1; then
        missing_cpanm_modules+=("$m")
    fi
done

missing_apt_packages=()
for p in "${apt_packages[@]}"; do
    if ! dpkg -s "$p" >/dev/null 2>&1; then
        missing_apt_packages+=("$p")
    fi
done

if [[ ${#missing_cpanm_modules[@]} -eq 0 && ${#missing_apt_packages[@]} -eq 0 ]]; then
    echo "All cpanm modules and apt packages required for installing VEP are already installed."
    exit 0
fi

if [[ ${#missing_cpanm_modules[@]} -gt 0 ]]; then
    echo "Missing cpanm modules:"
    echo "    ${missing_cpanm_modules[*]}"
    echo
fi

if [[ ${#missing_apt_packages[@]} -gt 0 ]]; then
    echo "Missing apt packages (needs sudo):"
    echo "    ${missing_apt_packages[*]}"
    echo
fi

read -p "Install missing packages? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

if [[ ${#missing_cpanm_modules[@]} -gt 0 ]]; then
    cpanm "${missing_cpanm_modules[@]}"
fi

if [[ ${#missing_apt_packages[@]} -gt 0 ]]; then
    sudo apt-get install "${missing_apt_packages[@]}"
fi

cd ${HOME}/.dotfiles/modules/mypkg/packages

git clone https://github.com/Ensembl/ensembl-vep.git

cd ensembl-vep

perl INSTALL.pl

ln -s $(realpath ./vep) ~/.local/bin/vep
