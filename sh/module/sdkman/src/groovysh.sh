#! /usr/bin/env sh

_sdkman_groovy_jsoup() {
    local url
    url=$(curl -s http://jsoup.org/news/ | s "/news/release" | s -o "(?<=href=\").*?(?=\">)" | head -1 | s -o "(?<=/news/release-).*")
    echo $url
}

my_groovysh() {
    groovysh -cp "$HOME/.groovy/jsoup-1.8.3.jar"
}
