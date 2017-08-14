#! /usr/bin/env bash

_branch(){
    if [[ -f .git/HEAD ]]; then
        echo "$(git rev-parse --abbrev-ref HEAD) "

    elif which git &> /dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then
        echo "$(git rev-parse --abbrev-ref HEAD) "
    elif [[ -d .hg ]]; then
        echo "$(hg branch) "
    elif which hg &> /dev/null && [[ -n "$(hg root 2> /dev/null)" ]]; then
        echo "$(hg branch) "
    fi
}

PS1="[\\j] \${MY_CURRENT_PACKAGE_MANAGER} \\u \\[\e[32m\\]\${PWD}\\[\e[0m\\] \$(_branch)\\$ "

# make `pwd` as iterm2 tab title
PROMPT_COMMAND+=' echo -ne "\033]0;${PWD##*/}\007";'
