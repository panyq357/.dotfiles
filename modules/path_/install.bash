from=$(dirname $BASH_SOURCE)/path.bash
to=${HOME}/.path.bash

if [[ -e $to ]]; then
    echo "$to exists, skip."
else
    cp $from $to
fi
