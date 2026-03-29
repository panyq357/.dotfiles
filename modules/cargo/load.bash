cargo_dir="$HOME/.cargo/"

if ! [ -d ${cargo_dir} ]; then
    echo "${cargo_dir} not found, please install cargo."
    return 1
fi

. $cargo_dir/env
