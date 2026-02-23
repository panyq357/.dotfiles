path_arr=(
    "${HOME}/tools/bin"
)

for p in ${path_arr[@]} ; do  # lower case "path" is a reserved variable, don't use it.
    if [[ "$PATH" != *"$p"* ]]; then
        PATH="${p}:${PATH}"
    fi
done

export PATH
