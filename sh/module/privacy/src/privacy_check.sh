#! /usr/bin/env bash

my_privacy_check() {
    if [[ "$#" == 1 ]];then
        $1 $(whoami)
    else
        echo "Usage: my_privacy_check source_search_program_command(like ag)"
    fi
}
