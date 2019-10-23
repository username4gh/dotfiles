
_ctags_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/ctags" ]];then
        git clone --depth 1 https://github.com/universal-ctags/ctags "$MY_DOTFILES_RESOURCES/ctags"
    fi
}

export PATH="$MY_DOTFILES_RESOURCES/ctags:$PATH"
