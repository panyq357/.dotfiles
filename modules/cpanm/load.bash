if ! command -v cpanm >/dev/null 2>&1; then
    echo "cpanm not found, please install it first." >&2
    echo
    echo "    cd ~/.local/bin; curl -L https://cpanmin.us/ -o cpanm; chmod u+x cpanm; cd -"
    echo
    return 1
fi

if [[ ! -f ~/perl5/lib/perl5/local/lib.pm ]]; then
    cpanm --local-lib=~/perl5 local::lib
fi

eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
