#! /usr/bin/env sh

_gitignore_init_compleat() {
    local filename
    if [[ ! -f "$HOME/.compleat/gitignore.usage" ]];then
        while IFS= read -r file
        do
            filename="${file##*/}"
            echo ${filename%.*}>> "$HOME/.compleat/gitignore.usage"
        done < <(find "$MY_REPO/gitignore" -mindepth 1 -maxdepth 1 -type f -name '*.gitignore')
    fi
}
