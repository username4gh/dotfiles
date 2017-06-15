#! /usr/bin/env bash

if _is_linux;then
    alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p"
    alias meminfo='free -m -l -t'
fi
