if [[ ! -d "$MY_DEPENDENCIES/z" ]];then
    git clone https://github.com/rupa/z "$MY_DEPENDENCIES/z"
fi

source "$MY_DEPENDENCIES/z/z.sh"
