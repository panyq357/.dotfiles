# Config for Java version manager SDKMAN! <https://sdkman.io/>

export SDKMAN_DIR="$HOME/.sdkman"

if [ -d "$SDKMAN_DIR" ] ; then

    java_home_path="$SDKMAN_DIR/candidates/java/current"

    if [ -e $java_home_path ] ; then
        export JAVA_HOME=$java_home_path
    fi

    java_bin_path="$SDKMAN_DIR/candidates/java/current/bin"
    maven_bin_path="$SDKMAN_DIR/candidates/maven/current/bin"

    if [ -e $java_bin_path  ] ; then
        export PATH="$java_bin_path:$PATH"
    fi
    if [ -e $maven_bin_path ] ; then
        export PATH="$maven_bin_path:$PATH"
    fi

    # Lazy loading SDKMAN!
    sdk () {
        . "$SDKMAN_DIR/bin/sdkman-init.sh"
        sdk $@
    }
fi
