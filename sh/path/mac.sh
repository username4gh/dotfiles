#! /bin/bash
if [[ "$(_check_os)" == "Darwin" ]]; then
    # no need to install any '*completion' package, leave it to oh-my-zsh/bash-it

    mp() {
        # https://www.topbug.net/blog/2013/10/23/use-both-homebrew-and-macports-on-your-os-x/
        if [[ "$#" -le 0 ]];then
            echo "Usage: $0 command [arg1, arg2, ...]" >&2;
            return;
        fi

        # keep macports remaining completely isolated
        (unset PATH;
        export PATH="/usr/bin"
        export PATH="/opt/local/bin:$PATH"
        export PATH="/opt/local/sbin:$PATH"
        export PATH="/opt/local/libexec/gnubin:$PATH"

        export MANPATH=/usr/share/man:/usr/local/share/man:/usr/X11/man
        export MANPATH="/opt/local/share/man:/opt/local/man:${MANPATH}"

        command=$1

        shift

        exec $command $*)
    }
fi
