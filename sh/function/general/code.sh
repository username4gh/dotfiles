#! /usr/bin/env sh

# some pre-defined variants might come in handy
# MY_I3 root dir of this `dotfiles`
# MY_BASH_CONFIG root dir of this `bash_config`

#Description https://code.visualstudio.com/Docs/editor/setup

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
