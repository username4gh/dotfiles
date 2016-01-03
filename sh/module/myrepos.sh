#! /bin/sh

if [[ ! -d "$HOME/repo/myrepos" ]];then
    git clone https://github.com/joeyh/myrepos "$HOME/repo/myrepos"
fi

if [[ ! -f "$HOME/.mrconfig" ]];then
    if [[ -f "$HOME/repo/my-i3/.mrconfig" ]];then
        ln -s "$HOME/repo/my-i3/.mrconfig" "$HOME/"
    fi
fi

export PATH="$HOME/repo/myrepos:$PATH"

_myrepos_get_remote_url() {
    (cd "$1";
    local url;
    url=$(git-info | grep 'remote.origin.url=' | sed "s/remote.origin.url=//g") ;
    echo "$url")
}

_myrepos_info() {
    local file
    while IFS= read -r -d '' file
    do
        if [[ -d "$file/.git" ]];then
            _myrepos_get_remote_url "$file"
        fi
    done < <(find "$HOME/repo" -mindepth 1 -maxdepth 1 -type d -print0)
}

myrepos_register_all() {
    if [[ -f "$HOME/repo/my-i3/.mrconfig" ]];then
        rm "$HOME/repo/my-i3/.mrconfig"
    fi

    local file
    while IFS= read -r -d '' file
    do
        echo "$file"
        if [[ -d "$file/.git" ]];then
            url=$(_myrepos_get_remote_url "$file")
            echo "[${file/#$HOME\//}]" >> "$HOME/repo/my-i3/.mrconfig" \
                && echo "checkout = git clone '"$url"' '"${file/#$HOME\//}"'" >> "$HOME/repo/my-i3/.mrconfig"
        fi
    done < <(find "$HOME/repo" -mindepth 1 -maxdepth 1 -type d -print0)
}

alias mr='mr -d ~'
