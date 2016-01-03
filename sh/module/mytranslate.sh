#! /usr/bin/env bash
if [[ ! -d "$HOME/repo/translate-shell" ]];then
    git clone https://github.com/soimort/translate-shell "$HOME/repo/translate-shell"
fi

mytranslate() {
    (cd $HOME/repo/translate-shell; ./translate "$1";)
}
