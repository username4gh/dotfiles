#! /bin/sh

if [[ ! -d "$MY_DEPENDENCIES/myrepos" ]];then
    git clone https://github.com/joeyh/myrepos "$MY_DEPENDENCIES/myrepos"
fi

export PATH="$MY_DEPENDENCIES/myrepos:$PATH"
