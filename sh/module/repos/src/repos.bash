#! /bin/sh

if [[ ! -d "$MY_REPO/myrepos" ]];then
    git clone https://github.com/joeyh/myrepos "$MY_REPO/myrepos"
fi

export PATH="$MY_REPO/myrepos:$PATH"

_repos_get_url() {
    (cd "$1";
    local url;
    url=$(git config --list | s 'remote.origin.url' | s -o '(?<=remote\.origin.url\=).*?(?=$)') ;
    echo "$url")
}

repos_register_all() {
    local mrconfig_directory
    local repos_directory
    if [[ "$#" -eq 0 ]];then
        mrconfig_directory=$MY_REPO
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
