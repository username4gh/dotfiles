#! /usr/bin/env bash

mytranslate() {
    (pushd $HOME/repo/translate-shell; ./translate "$1";popd)
}
