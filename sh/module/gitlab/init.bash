#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$MY_SH_MODULE/gitlab/script:$PATH"
fi
