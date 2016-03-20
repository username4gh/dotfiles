#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/gitignore" ]];then
    git clone https://github.com/github/gitignore "$MY_REPO/gitignore"
fi

my_git_ignore_init() {
    if [[ ! -d "$(pwd)/.git" ]];then
        echo "my_git_ignore_init can only be used in the root dir of a git repo"
        return
    fi

    if [[ "$#" == 1 ]];then
        if [[ ! -f "$(pwd)/.gitignore" ]];then
            cp "$MY_REPO/gitignore/$1.gitignore" "$pwd/.gitignore"
        fi
    else
        echo "Usage: my_git_ignore_init template"
    fi
}
