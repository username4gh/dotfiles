if [[ ! -d "$MY_DOTFILES/ctags" ]];then
    git clone https://github.com/universal-ctags/ctags "$MY_DOTFILES/ctags"
fi

export PATH="$MY_DOTFILES/ctags:$PATH"
