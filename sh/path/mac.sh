#! /bin/bash
if [[ "$(_check_os)" == "Darwin" ]]; then
    # no need to install any '*completion' package, leave it to oh-my-zsh/bash-it
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export PATH="/opt/local/libexec/gnubin:$PATH"

    export MANPATH=/usr/share/man:/usr/local/share/man:/usr/X11/man
    export MANPATH="/opt/local/share/man:/opt/local/man:${MANPATH}"
fi
