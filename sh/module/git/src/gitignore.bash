#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/gitignore" ]];then
    git clone https://github.com/github/gitignore "$MY_REPO/gitignore"
fi

_gitignore_merge() {
    if [[ "$#" == 2 ]];then
        mv ./.gitignore ./.gitignore.previous
        cat $1 >> ./.gitignore.previous
        $MY_SH_MODULE/git/src/gitignore_merger.py -i ./.gitignore.previous -o ./.gitignore
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
            cp "$MY_REPO/gitignore/$1.gitignore" "$pwd/.gitignore"
        else
            _gitignore_merge "$MY_REPO/gitignore/$1.gitignore" "$pwd/.gitignore"
        fi
    else
        echo "Usage: my_git_ignore_init template"
    fi
}

_completion_generate my_git_ignore_init "$MY_REPO/gitignore/*.gitignore"
_completion_setup my_git_ignore_init