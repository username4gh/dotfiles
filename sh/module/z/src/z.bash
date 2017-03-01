if [[ ! -d "$MY_DOTFILES_RESOURCES/z" ]];then
    git clone https://github.com/rupa/z "$MY_DOTFILES_RESOURCES/z"
fi

source "$MY_DOTFILES_RESOURCES/z/z.sh"
