#! /usr/bin/env bash

# this script will delete all the file that's personal and concerns privacy

(cd $HOME; 

rm -rvf .atom

rm -rvf .bash*

rm -rvf .config

rm -rvf .csearchindex

rm -rvf .enhancd

# global git config
rm -rvf .gitconfig

rm -rvf .local

rm -rvf .npm

rm -rvf .nvm

rm -rvf .profile

rm -rvf .python_history

rm -rvf .rvm

rm -rvf .sack*

rm -rvf .sdkman

rm -rvf .ShadowsocksX

rm -rvf .sogouinput

rm -rvf .ssh

rm -rvf .vim*;

rm -rvf .wget-hsts

rm -rvf .workspace.dmg.sparseimage

# z & zsh
rm -rvf .z*
)
