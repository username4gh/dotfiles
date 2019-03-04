#! /usr/bin/env bash

if _is_not_root;then
    export PATH="$MY_SH_MODULE/gitlab/script:$PATH"
fi
