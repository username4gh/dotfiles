#! /usr/bin/env bash

privacy_check() {
    if [[ "$#" == 1 ]];then
        $1 $(whoami)
    else
        echo "Usage: privacy_check source_search_program_command(like ag)"
    fi
}
