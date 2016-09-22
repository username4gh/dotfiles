#! /usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [[ ! -d "$MY_DOTFILES/hstr" ]];then
    git clone https://github.com/dvorka/hstr "$MY_DOTFILES/hstr"
fi

_hstr_init() {
    (cd "$MY_DOTFILES/hstr" && cd ./dist && ./1-dist.sh && cd .. && ./configure && make)
}

export HH_CONFIG=hicolor
export PATH="$MY_DOTFILES/hstr/src:$PATH"
