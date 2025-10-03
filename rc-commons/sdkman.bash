# Config for Java version manager SDKMAN! <https://sdkman.io/>

export SDKMAN_DIR="$HOME/.sdkman"

# Lazy loading sdk command.
if [ -d "$SDKMAN_DIR" ] ; then
    sdk() {
        [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"
        # After source above, sdk command have been replaced.
        sdk $@
    }
fi
