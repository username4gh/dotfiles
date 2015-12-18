#!/usr/bin/env bash

# If not running interactively, don't do anything 
# this line has to be placed at this front-pos, 
# otherwise the rsync will not work
case $- in
    *i*) ;;
    *) return;;
esac

# despite there are some issue with bash-it, but still the price to maintain a brand new config with 
# at least the same quality is too high, so my approach is trying to build sth based on it.

# Path to the bash it configuration
# cause the variant's availability only get checked when acctually being used
export BASH_IT="$HOME/.bash_it"

_my_bash_it_load_one() {
    file_type=$1
    file_to_enable=$2
    [ ! -d "$BASH_IT/$file_type/enabled" ] && mkdir "$BASH_IT/${file_type}/enabled"

    dest="${BASH_IT}/${file_type}/enabled/${file_to_enable}"
    if [ ! -e "${dest}" ]; then
        ln -s "../available/${file_to_enable}" "${dest}"
    else
        echo "File ${dest} exists, skipping"
    fi
}

_my_bash_it_load_some() {
    file_type=$1
    [ -d "$BASH_IT/$file_type/enabled" ] || mkdir "$BASH_IT/$file_type/enabled"
    for path in `ls $BASH_IT/${file_type}/available/[^_]*`
    do
        file_name=$(basename "$path")
        while true
        do
            read -e -n 1 -p "Would you like to enable the ${file_name%%.*} $file_type? [y/N] " RESP
            case $RESP in
                [yY])
                    ln -s "../available/${file_name}" "$BASH_IT/$file_type/enabled"
                    break
                    ;;
                [nN]|"")
                    break
                    ;;
                *)
                    echo -e "\033[91mPlease choose y or n.\033[m"
                    ;;
            esac
        done
    done
}

# bash-it default config
if [[ ! -d "$HOME/.bash_it" ]];then
    pushd "$HOME" \
        && git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it \
        || popd;

    if [[ "$1" == "--interactive" ]];then
        for type in "aliases" "plugins" "completion";
        do
            echo -e "\033[0;32mEnabling $type\033[0m"
            _my_bash_it_load_some $type
        done
    else
        echo ""
        echo -e "\033[0;32mEnabling some defaults\033[0m"
        _my_bash_it_load_one completion bash-it.completion.bash
        _my_bash_it_load_one plugins alias-completion.plugin.bash
        _my_bash_It_load_one aliases general.aliases.bash
    fi

    echo ""
    echo -e "\033[0;32mInstallation finished successfully! Enjoy bash-it!\033[0m"
    echo -e "\033[0;32mTo start using it, open a new tab or 'source "$HOME/$CONFIG_FILE"'.\033[0m"
    echo ""
    echo "To show the available aliases/completions/plugins, type one of the following:"
    echo "  bash-it show aliases"
    echo "  bash-it show completions"
    echo "  bash-it show plugins"
    echo ""
    echo "To avoid issues and to keep your shell lean, please enable only features you really want to use."
    echo "Enabling everything can lead to issues."
fi

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Only set $BASH_IT if it's not already set
if [ -z "$BASH_IT" ];then
    # Setting $BASH to maintain backwards compatibility
    # TODO: warn users that they should upgrade their .bash_profile
    export BASH_IT=$BASH
    export BASH=`bash -c 'echo $BASH'`
fi

# Load composure first, so we support function metadata
source "${BASH_IT}/lib/composure.bash"

# support 'plumbing' metadata
cite _about _param _example _group _author _version

# library(we only need the helpers.bash to use the '.bash_it' stuff)
source ${BASH_IT}/lib/helpers.bash

# Load enabled aliases, completion, plugins
for file_type in "aliases" "completion" "plugins"
do
  _load_bash_it_files $file_type
done
unset file_type

# custom
CUSTOM="${BASH_IT}/custom/*.bash"
for config_file in $CUSTOM
do
  if [ -e "${config_file}" ]; then
    source $config_file
  fi
done
unset CUSTOM
unset config_file

export MY_CURRENT_SHELL='bash'
# integration with my own stuff with bash-it
if [[ -f "$HOME/repo/my-i3/sh/init.sh" ]];then
    source "$HOME/repo/my-i3/sh/init.sh";
fi

source "$HOME/repo/my-i3/.profile"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ubuntu/.sdkman"
[[ -s "/home/ubuntu/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ubuntu/.sdkman/bin/sdkman-init.sh"
