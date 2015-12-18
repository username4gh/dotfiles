#! /bin/bash

if [[ "$(_check_command 'unzip')" == 1 ]];then
    if [[ ! -d "$HOME/.sdkman" ]]; then
        curl -s http://get.sdkman.io | bash
    fi
else
    echo "SDKMAN requires 'unzip'!"
fi
