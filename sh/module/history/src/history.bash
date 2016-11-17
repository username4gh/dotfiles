#! /usr/bin/env bash
if [[ "$MY_CURRENT_SHELL" = 'bash' ]];then
    export MY_HISTORY_DIR="$MY_DOTFILES/my-history"

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    # HISTSIZE is the number of lines or commands that are stored in memory in a history list while your bash session is ongoing.

    # HISTFILESIZE is the number of lines or commands that (a) are allowed in the history file at startup time of a session,
    # and (b) are stored in the history file at the end of your bash session for use in future sessions.

    HISTSIZE=1000
    HISTFILESIZE=2000
    # append to the history file, don't overwrite it
    PROMPT_COMMAND="_history_exclude_invalid_command; history -a; ${PROMPT_COMMAND}"
    shopt -s histappend
    export HISTCONTROL=ignoreboth:ignoredups
    export HISTIGNORE="_no_invalid_command_in_history:[   ]*:&:ag:bg:cat*:cd*:df*:echo*:fg:exit:hh*:history*:git*:ls*:mv*:rfc:rlc:sbs:src:z"
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
            && _history_save
    fi
fi
