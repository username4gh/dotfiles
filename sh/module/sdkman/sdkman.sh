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
    url=$(curl -s http://jsoup.org/news/ | ack "/news/release" | ack -o "(?<=href=\").*?(?=\">)" | head -1 | ack -o "(?<=/news/release-).*")
    echo $url
}
