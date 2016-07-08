if [[ ! -d "$MY_REPO/z" ]];then
    git clone https://github.com/rupa/z "$MY_REPO/z"
fi

source "$MY_REPO/z/z.sh"

export MANPATH="$MY_REPO/z:${MANPATH}"
