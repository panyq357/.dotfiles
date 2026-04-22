if [[ -d ${HOME}/.rbenv ]] ; then
    eval "$(~/.rbenv/bin/rbenv init - $SHELL)"
else
    echo "rbenv not found, please install:"
    echo ""
    echo "    git clone https://github.com/rbenv/rbenv.git ~/.rbenv"
    echo "    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build"
    echo ""
fi
