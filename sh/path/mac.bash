#! /usr/bin/env bash
if [[ "$(_check_os)" == 'Darwin' ]]; then
    # no need to install any '*completion' package, leave it to oh-my-zsh/bash-it

    # keep macports remaining completely isolated
    export PATH="/opt/local/bin:$PATH"
    export PATH="/opt/local/sbin:$PATH"
    export PATH="/opt/local/libexec/gnubin:$PATH"

    export MANPATH="/usr/share/man:/usr/local/share/man:/usr/X11/man"
    export MANPATH="/opt/local/share/man:/opt/local/man:${MANPATH}"

    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
        . /opt/local/etc/profile.d/bash_completion.sh
    fi
fi
