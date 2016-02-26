#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/enhancd" ]];then
	git clone https://github.com/b4b4r07/enhancd "$MY_REPO/enhancd"
fi

export ENHANCD_COMMAND=ecd
export ENHANCD_FILTER="myfzf"

source "$MY_REPO/enhancd/enhancd.sh"