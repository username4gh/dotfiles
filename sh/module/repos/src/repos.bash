#! /bin/sh

if [[ ! -d "$MY_DOTFILES_RESOURCES/myrepos" ]];then
    git clone https://github.com/joeyh/myrepos "$MY_DOTFILES_RESOURCES/myrepos"
fi

export PATH="$MY_DOTFILES_RESOURCES/myrepos:$PATH"
