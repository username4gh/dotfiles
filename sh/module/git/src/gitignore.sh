#! /usr/bin/env sh

if [[ ! -d "$MY_REPO/gitignore" ]];then
    git clone https://github.com/github/gitignore "$MY_REPO/gitignore"
fi

_gitignore_merge() {
    if [[ "$#" == 2 ]];then
        mv ./.gitignore ./.gitignore.previous
        cat $1 >> ./.gitignore.previous
        $MY_SH_MODULE/git/src/gitignore_merger -i ./.gitignore.previous -o ./.gitignore
        rm ./.gitignore.previous
    else
        echo "Usage: _gitignore_merge srcfile targetfile"
    fi
}

_gitignore_init_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local available_things=$(for f in $(ls -1 $MY_REPO/gitignore/*.gitignore);
    do
        basename $f | cut -d '.' -f1
    done)

    COMPREPLY=( $(compgen -W "${available_things}" -- ${cur}) )
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

complete -F _gitignore_init_complete my_git_ignore_init
