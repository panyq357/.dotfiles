# Config for Java version manager SDKMAN! <https://sdkman.io/>

export SDKMAN_DIR="$HOME/.sdkman"

if [ -d "$SDKMAN_DIR" ] ; then

    # Add bin directory of maven, gradle, java, ... to PATH.
    for x in $(ls "$SDKMAN_DIR/candidates/") ; do
        p="$SDKMAN_DIR/candidates/$x/current/bin"
        if [ -e $p ] ; then
            export PATH="$p:$PATH"
        fi
    done

    # Make JAVA_HOME enviroment variable.
    java_home_path="$SDKMAN_DIR/candidates/java/current"
    if [ -e $java_home_path ] ; then
        export JAVA_HOME=$java_home_path
    fi

    # Lazy loading SDKMAN!
    sdk () {
        . "$SDKMAN_DIR/bin/sdkman-init.sh"
        sdk $@
    }
fi
