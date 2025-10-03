# Config for Java version manager SDKMAN! <https://sdkman.io/>

export SDKMAN_DIR="$HOME/.sdkman"

if [ -d "$SDKMAN_DIR" ] ; then

    export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
    export PATH="$SDKMAN_DIR/candidates/java/current/bin:$PATH"

    # Lazy loading SDKMAN!
    sdk () {
        . "$SDKMAN_DIR/bin/sdkman-init.sh"
        sdk $@
    }
fi
