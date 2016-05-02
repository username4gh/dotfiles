#! /bin/bash
if [[ "$MY_CURRENT_SHELL" = 'bash' ]];then
    export MY_HISTORY_DIR="$MY_REPO/my-history"

    _save_history() {
        if [[ "$(_check_dir "$MY_HISTORY_DIR")" == 1 ]]; then
            # there is a threshold for history file, so it might cause 'git command' not always
            # return true
            (cd "$MY_HISTORY_DIR" \
                && git add . \
                && git commit -am save)
        else
            echo 'please enter the git address of history repo'
            read history_repo_address
            if [[ "$history_repo_address" != '' ]];then
                git clone "$history_repo_address" "$MY_HISTORY_DIR" && ln -s "$MY_HISTORY_DIR/.bash_history.archive" ~/.bash_history.archive
            fi
        fi
    }

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    # HISTSIZE is the number of lines or commands that are stored in memory in a history list while your bash session is ongoing.

    # HISTFILESIZE is the number of lines or commands that (a) are allowed in the history file at startup time of a session,
    # and (b) are stored in the history file at the end of your bash session for use in future sessions.

    HISTSIZE=1000
    HISTFILESIZE=2000
    # append to the history file, don't overwrite it
    PROMPT_COMMAND+=" history -a; history -n;"
    shopt -s histappend
    export HISTCONTROL=ignoreboth
    export HISTIGNORE="[   ]*:&:bg:cd:fg:exit:ls:history"
    export HISTTIMEFORMAT='%F %T '

    # stolen from http://mywiki.wooledge.org/BashFAQ/088
    umask 077
    max_lines=1000

    linecount=$(wc -l < ~/.bash_history)

    if ((linecount > max_lines)); then
        #prune_lines=$((linecount - max_lines))
        prune_lines=$((max_lines))
        head -$prune_lines ~/.bash_history >> ~/.bash_history.archive \
            && sed -e "1,${prune_lines}d"  ~/.bash_history > ~/.bash_history.tmp$$ \
            && mv ~/.bash_history.tmp$$ ~/.bash_history \
            && _save_history
    fi

    _history_backup() {
        cat ~/.bash_history >> ~/.bash_history.archive
    }
fi
