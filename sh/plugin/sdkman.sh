#! /bin/bash

if [[ "$(_check_command 'unzip')" == 1 ]];then
    if [[ ! -d "$HOME/.sdkman" ]]; then
        curl -s http://get.sdkman.io | bash
    fi
else
    echo "SDKMAN requires 'unzip'!"
fi

_sdkman_groovy_jsoup() {
    local url
    url=$(curl -s http://jsoup.org/news/ | grep "/news/release" | grep -Po "(?<=href=\").*?(?=\">)" | head -1 | grep -Po "(?<=/news/release-).*")
    echo $url
}
