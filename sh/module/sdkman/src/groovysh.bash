#! /usr/bin/env bash

my_groovysh() {
    if [[ ! -f "$HOME/.groovy/groovysh.profile" ]];then
        cp "$MY_I3/groovysh.profile" "$HOME/.groovy/"
    fi

    local JSOUP_JAR="$(ls -a "$HOME/.groovy/"| s 'jsoup-.*?.jar')"
    cat "$MY_I3/groovysh.profile"
    if [[ -f "$HOME/.groovy/$JSOUP_JAR" ]];then
        groovysh -cp "$HOME/.groovy/$JSOUP_JAR"
    fi
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
    curl "$url" -o "$HOME/.groovy/$(_file_name_from_url $url)"
}

_sdkman_groovy_init() {
    _sdkman_download_jsoup
}
