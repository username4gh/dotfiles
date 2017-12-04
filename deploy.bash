#! /usr/bin/env bash

MY_DOTFILES_RESOURCES="$HOME/.dotfiles_resources"
MY_DEPLOY_BACKUP="$MY_DOTFILES_RESOURCES/backup"

if [[ ! -d "$MY_DOTFILES_RESOURCES" ]];then
    mkdir -p "$MY_DOTFILES_RESOURCES"
fi

if [[ ! -d "$MY_DEPLOY_BACKUP" ]];then
    mkdir -p "$MY_DEPLOY_BACKUP"
fi

files=('main.bash' 'main.bash' '.inputrc' '.translate-shell' '.vimrc')
targets=('.bashrc' '.bash_profile' '.inputrc' '.translate-shell' '.vimrc')

for((i=0; i<${#files[@]}; i++))
do
    if [[ -h "$HOME/${targets[$i]}" ]];then
        rm -v "$HOME/${targets[$i]}"
    fi


    if [[ -f "$HOME/${targets[$i]}" ]];then
        mv -v "$HOME/${targets[$i]}" "$MY_DOTFILES_RESOURCES/backup/"
    fi

    ln -vs "$HOME/.dotfiles/${files[$i]}" "$HOME/${targets[$i]}"
done
