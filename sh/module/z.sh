if [[ ! -d "$HOME/repo/z" ]];then
    git clone https://github.com/rupa/z "$HOME/repo/z"
fi

source "$HOME/repo/z/z.sh"

export MANPATH="$HOME/repo/z:${MANPATH}"
