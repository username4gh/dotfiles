#! /usr/bin/env bash

if [[ "$(_check_file "$MY_BIN/ack")" == 0 ]];then
    curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 "$MY_BIN/ack"
fi
