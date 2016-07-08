#! /usr/bin/env bash

if [[ "$(_check_command)" == 'Linux' ]];then
    alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p"
    alias meminfo='free -m -l -t'
fi
