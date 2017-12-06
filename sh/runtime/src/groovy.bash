#! /usr/bin/env bash

_groovysh() {
    if [[ ! -f "$HOME/.groovy/groovysh.profile" ]];then
        cp "$MY_DOTFILES/groovysh.profile" "$HOME/.groovy/"
    fi

    local JARS="$(find "$HOME/.groovy" -type f -iname "*.jar")"
    local CLASS_PATH="${JARS//[[:space:]]/:}"
    echo "loading $HOME/.groovy/groovysh.profile"
    cat "$HOME/.groovy/groovysh.profile"
    command groovysh -cp "$CLASS_PATH"
}

alias groovysh='_groovysh'

GROOVY_PATH="$(_autodetect_bin "groovy-*")"

if [[ -d "$GROOVY_PATH" ]];then
    export PATH="$GROOVY_PATH/bin:$PATH"
fi

unset GROOVY_PATH
