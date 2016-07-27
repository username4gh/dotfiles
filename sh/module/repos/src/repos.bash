#! /bin/sh

if [[ ! -d "$MY_REPO/myrepos" ]];then
    git clone https://github.com/joeyh/myrepos "$MY_REPO/myrepos"
fi

if [[ ! -f "$HOME/.mrconfig" ]];then
    if [[ -f "$MY_I3/.mrconfig" ]];then
        ln -s "$MY_I3/.mrconfig" "$HOME/"
    fi
fi

export PATH="$MY_REPO/myrepos:$PATH"

_repos_get_url() {
    (cd "$1";
    local url;
    url=$(s -f .git/config 'url = ' | sed "s/url = //g") ;
    echo "$url")
}

_repos_info() {
    local file
    while IFS= read -r -d '' file
    do
        if [[ -d "$file/.git" ]];then
            _repos_get_url "$file"
        fi
    done < <(find "$MY_REPO" -mindepth 1 -maxdepth 1 -type d -print0)
}

my_repos_register_all() {
    local mrconfig_directory
    local repos_directory
    if [[ "$#" -eq 0 ]];then
        mrconfig_directory=$MY_I3
        repos_directory=$MY_REPO
    else
        mrconfig_directory=$1
        repos_directory=$1
    fi

    if [[ -f "$mrconfig_directory/.mrconfig" ]];then
        rm -v "$mrconfig_directory/.mrconfig"
    fi

    local file
    while IFS= read -r -d '' file
    do
        echo "$file"
        if [[ -d "$file/.git" ]];then
            url=$(_repos_get_url "$file")
            echo "[${file/#$HOME\//}]" >> "$mrconfig_directory/.mrconfig" \
                && echo "checkout = git clone '"$url"' '"${file/#$HOME\//}"'" >> "$mrconfig_directory/.mrconfig"
        fi
    done < <(find "$repos_directory" -mindepth 1 -maxdepth 1 -type d -print0)
}

_repos_backup() {
    # first I register all the git repos to the mrconfig
    my_repos_register_all

    # then I just copy the updated '.mrconfig' to the backup dir
    cp "$HOME/.mrconfig" "$(_backup_get_dest_dir)/"
}
