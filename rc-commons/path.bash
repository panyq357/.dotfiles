path_arr=(
    "${HOME}/tools/bin"

    "${HOME}/tools/nvim-linux-x86_64/bin"
    "${HOME}/tools/STAR_2.7.11b/Linux_x86_64_static"
    "${HOME}/tools/node-v22.18.0-linux-x64/bin"
    "${HOME}/tools/meme-5.5.8/bin"
    "${HOME}/tools/meme-5.5.8/libexec/meme-5.5.8"
    "${HOME}/tools/annovar"
    "${HOME}/tools/apache-maven-3.9.11/bin"
    "${HOME}/tools/jdt-language-server-1.49.0/bin"
    "${HOME}/tools/sratoolkit.3.2.1-ubuntu64/bin"
    "${HOME}/tools/obsutil_linux_amd64_5.7.3"
    "${HOME}/tools/minimap2-2.30_x64-linux"
    "${HOME}/tools/ucsc-utilities"

    "${HOME}/repos/ensembl-vep"
    "${HOME}/repos/tassel-5-standalone"

)

for p in ${path_arr[@]} ; do  # lower case "path" is a reserved variable, don't use it.
    if [[ "$PATH" != *"$p"* ]]; then
        export PATH="${p}:${PATH}"
    fi
done
