if [[ ! -d "$MY_DOTFILES/z" ]];then
    git clone https://github.com/rupa/z "$MY_DOTFILES/z"
fi

source "$MY_DOTFILES/z/z.sh"
