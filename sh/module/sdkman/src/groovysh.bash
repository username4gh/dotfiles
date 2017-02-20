#! /usr/bin/env bash

my_groovysh() {
    if [[ ! -f "$HOME/.groovy/groovysh.profile" ]];then
        cp "$MY_DEPENDENCIES/groovysh.profile" "$HOME/.groovy/"
    fi

    local JARS="$(find "$HOME/.groovy" -type f -iname "*.jar")"
    local CLASS_PATH="${JARS//[[:space:]]/:}"
    echo "loading $HOME/.groovy/groovysh.profile"
    cat "$HOME/.groovy/groovysh.profile"
    groovysh -cp "$CLASS_PATH"
}

_latest_jsoup_version_code() {
    local latest_version_code
    latest_version_code=$(curl -s https://jsoup.org/news/ | s "/news/release" | s -o "(?<=href=\").*?(?=\">)" | head -1 | s -o "(?<=/news/release-).*")
    echo $latest_version_code
}

_sdkman_jsoup_url(){
    echo "https://jsoup.org/packages/jsoup-$(_latest_jsoup_version_code).jar"
}

_sdkman_download_jsoup() {
    local url="$(_sdkman_jsoup_url)"
    curl "$url" -o "$HOME/.groovy/$(_file_name_from_uri $url)"
}

_sdkman_groovy_init() {
    _sdkman_download_jsoup
}
