for x in $(find $(dirname $BASH_SOURCE) -name "link.bash"); do
    source $x
    if [[ -L $to ]]; then
        if [[ $(readlink $to) == $from ]]; then
            rm $to
        else
            echo "${to} exists, but not point to ${from}, skip."
        fi
    else
        echo "${to} not found, skip."
    fi
done
