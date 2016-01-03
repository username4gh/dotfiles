#! /usr/bin/env bash

if [[ ! -d "$HOME/repo/enhancd" ]];then
	git clone https://github.com/b4b4r07/enhancd "$HOME/repo/enhancd"
fi

export ENHANCD_COMMAND=ecd
export ENHANCD_FILTER="myfzf"

source "$HOME/repo/enhancd/enhancd.sh"
