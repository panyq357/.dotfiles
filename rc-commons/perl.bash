if [ -d ${HOME}/perl5/lib/perl5 ] ; then
    eval "$(perl -I${HOME}/perl5/lib/perl5 -Mlocal::lib)"
fi
