#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/gitignore" ]];then
    git clone https://github.com/github/gitignore "$MY_DOTFILES/gitignore"
fi

_gitignore_merge() {
    if [[ "$#" == 2 ]];then
        mv ./.gitignore ./.gitignore.previous
        cat $1 >> ./.gitignore.previous
        $MY_SH_MODULE/git/script/gitignore_merger.py -i ./.gitignore.previous -o ./.gitignore
        rm ./.gitignore.previous
    else
        echo "Usage: _gitignore_merge.py srcfile targetfile"
    fi
}

my_git_ignore_init() {
    if [[ ! -d "$(pwd)/.git" ]];then
        echo "my_git_ignore_init can only be used in the root dir of a git repo"
        return
    fi

    if [[ "$#" == 1 ]];then
        if [[ ! -f "$(pwd)/.gitignore" ]];then
            cp "$MY_DOTFILES/gitignore/$1.gitignore" "$pwd/.gitignore"
        else
            _gitignore_merge "$MY_DOTFILES/gitignore/$1.gitignore" "$pwd/.gitignore"
        fi
    else
        echo "Usage: my_git_ignore_init template"
    fi
}

_completion_register_generate my_git_ignore_init $MY_DOTFILES/gitignore gitignore

_completion_setup my_git_ignore_init
