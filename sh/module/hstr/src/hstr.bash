#! /usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [[ ! -d "$MY_REPO/hstr" ]];then
    git clone https://github.com/dvorka/hstr "$MY_REPO/hstr"
fi

_hstr_init() {
    (cd "$MY_REPO/hstr" && cd ./dist && ./1-dist.sh && cd .. && ./configure && make)
}

export HH_CONFIG=hicolor
export PATH="$MY_REPO/hstr/src:$PATH"
