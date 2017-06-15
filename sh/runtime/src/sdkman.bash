#! /usr/bin/env bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"

if _is_command_exist 'unzip';then
    if [[ ! -d "$HOME/.sdkman" ]]; then
        curl -s http://get.sdkman.io | bash
    fi
else
    _sh_log "${BASH_SOURCE[0]}" "SDKMAN requires 'unzip'!"
fi
