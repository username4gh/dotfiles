#! /bin/sh

if [[ ! -d "$MY_DOTFILES/myrepos" ]];then
    git clone https://github.com/joeyh/myrepos "$MY_DOTFILES/myrepos"
fi

export PATH="$MY_DOTFILES/myrepos:$PATH"
