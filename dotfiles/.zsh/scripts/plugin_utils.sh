ZSH_PLUGIN_FOLDER=~/.zsh
GIT_USERNAME="zsh-users"
USE_HASH="no"
USE_PATCH="no"

load_plugin() {
    while [ $# -gt 1 ]; do
        case "$1" in
            -u|--user)
                GIT_USERNAME="$2"
                shift 2
            ;;
            -h|--hash)
                USE_HASH="yes"
                HASH="$2"
                shift 2
            ;;
            -p|--patch)
                USE_PATCH="yes"
                shift
            ;;
            *)
                echo "Unknown argument: $1"
            ;;
        esac
    done

    if [[ "$1" == "" ]]; then
        echo "No plugin provided for load_plugin"
    fi

    PLUGIN_NAME="$1"

    if [ ! -d $ZSH_PLUGIN_FOLDER/$PLUGIN_NAME ]; then
        git clone https://github.com/$GIT_USERNAME/$PLUGIN_NAME.git $ZSH_PLUGIN_FOLDER/$PLUGIN_NAME

        if [[ "$USE_HASH" == "yes" ]]; then
            git -C "$ZSH_PLUGIN_FOLDER/$PLUGIN_NAME" checkout "$HASH"
        fi
        if [[ "$USE_PATCH" == "yes" ]]; then
            echo "Patching..."
            PATCH_FOLDER="$ZSH_PLUGIN_FOLDER/patches/$PLUGIN_NAME"
            for p in $(ls $PATCH_FOLDER); do
                echo "Applying $p"
                git -C "$ZSH_PLUGIN_FOLDER/$PLUGIN_NAME" apply "$PATCH_FOLDER/$p"
            done
        fi
    fi
    source $ZSH_PLUGIN_FOLDER/$PLUGIN_NAME/$PLUGIN_NAME.zsh
}
