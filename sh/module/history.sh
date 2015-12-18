#! /bin/bash
if [[ "$MY_CURRENT_SHELL" = 'bash' ]];then
    _save_history() {
        if [[ "$(_check_dir "$HOME/repo/my-history")" == 1 ]]; then
            # there is a threshold for history file, so it might cause 'git command' not always 
            # return true
            pushd "$HOME/repo/bash_history_git" \
                && git add . \
                && git commit -am save
            popd
        else
            if [[ "$(_check_variant "$HISTORY_REPO")" == 1 ]]; then
                pushd "$HOME/repo" \
                    && git clone "$HISTORY_REPO" \
                    && ln -s "$HOME/repo/bash_history_git/.bash_history.archive" ~/.bash_history.archive \
                    && popd
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
    PROMPT_COMMAND+="history -a; history -n; "
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
fi
