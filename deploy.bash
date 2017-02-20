#! /usr/bin/env bash

if [[ -f "$HOME/.bashrc" ]];then
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi

ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bashrc"

if [[ -f "$HOME/.bash_profile" ]];then
    mv "$HOME/.bash_profile" "$HOME/.bash_profile.bak"
fi

ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"

if [[ -f "$HOME/.vimrc" ]];then
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
fi

ln -s "$HOME/.dotfiles/.vimrc.light" "$HOME/.vimrc"

