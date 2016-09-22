#! /usr/bin/env bash

_flatbuffers_init() {
	if [[ ! -d "$MY_DOTFILES/flatbuffers" ]];then
		git clone https://github.com/google/flatbuffers "$MY_DOTFILES/flatbuffers"
	fi
}

export PATH="$MY_DOTFILES/flatbuffers:$PATH"
