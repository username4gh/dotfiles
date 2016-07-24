#! /usr/bin/env bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"

if [[ "$(_check_command 'unzip')" == 1 ]];then
    if [[ ! -d "$HOME/.sdkman" ]]; then
        curl -s http://get.sdkman.io | bash
    fi
else
    echo "SDKMAN requires 'unzip'!"
fi

virtual_sdkman() {
    # https://www.topbug.net/blog/2013/10/23/use-both-homebrew-and-macports-on-your-os-x/
    if [[ "$#" -le 0 ]];then
        echo "Usage: $0 command [arg1, arg2, ...]" >&2;
        return;
    fi

    ([[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

    command=$1;

    shift

    $command $*)
}

_completion_register_write virtual_sdkman groovysh
_completion_register_write virtual_sdkman my_groovysh
_completion_register_write virtual_sdkman sdk

_completion_setup virtual_sdkman