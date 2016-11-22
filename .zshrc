export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git z zsh_reload)

source $ZSH/oh-my-zsh.sh

export MY_CURRENT_SHELL='zsh'
source "$HOME/.dotfiles/my-i3/sh/init.bash"
