#! /usr/bin/env bash

# http://superuser.com/questions/639295/is-negative-look-behind-supported-in-osx-grep
# BSD licensed grep only supports basic & extended regular-expression, so no 'look-*' feature
# hence here we use ack

# 2016/01/08 -- for ack-2.14, there is a bug while using '--count', see "https://github.com/petdance/ack2/issues/563"

if [[ ! -f "$MY_BIN/ack" ]];then
    curl -C - http://beyondgrep.com/ack-2.14-single-file -o "$MY_BIN/ack" && chmod 0755 "$MY_BIN/ack"
fi
