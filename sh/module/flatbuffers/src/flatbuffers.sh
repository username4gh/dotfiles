#! /usr/bin/env sh

if [[ ! -d "$MY_REPO/flatbuffers" ]];then
	git clone https://github.com/google/flatbuffers "$MY_REPO/flatbuffers"
fi

export PATH="$MY_REPO/flatbuffers:$PATH"
