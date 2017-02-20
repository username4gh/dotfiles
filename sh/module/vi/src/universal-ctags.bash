if [[ ! -d "$MY_DEPENDENCIES/ctags" ]];then
    git clone https://github.com/universal-ctags/ctags "$MY_DEPENDENCIES/ctags"
fi

export PATH="$MY_DEPENDENCIES/ctags:$PATH"
