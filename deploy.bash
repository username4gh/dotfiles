#! /usr/bin/env bash

files=('.bashrc' '.bash_profile' '.inputrc' '.vimrc')

for((i=0; i<${#files[@]}; i++))
do
    rm -v "$HOME/${files[$i]}"

done

ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bashrc"

ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"

ln -s "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"

ln -s "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"

ln -s "$HOME/.dotfiles/.translate-shell" "$HOME/.translate-shell"
