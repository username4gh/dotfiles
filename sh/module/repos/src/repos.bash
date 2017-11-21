#! /bin/sh

_repos_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/myrepos" ]];then
        git clone git://myrepos.branchable.com/ "$MY_DOTFILES_RESOURCES/myrepos"
    fi
}

export PATH="$MY_DOTFILES_RESOURCES/myrepos:$PATH"
