# Config for Java version manager SDKMAN! <https://sdkman.io/>
if [ -d "$HOME/.sdkman" ] ; then
    export SDKMAN_DIR="$HOME/.sdkman"
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
