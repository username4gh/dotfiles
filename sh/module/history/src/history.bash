#! /usr/bin/env bash
if [[ "$MY_CURRENT_SHELL" = 'bash' ]];then
    export MY_HISTORY_DIR="$MY_DOTFILES/my-history"

    _init_history() {
        if [[ "$(_check_dir "$MY_HISTORY_DIR")" == 0 ]];then
            echo 'plz enter the git address of history repo'
            read history_repo_address
            if [[ "$history_repo_address" != '' ]];then
                git clone "$history_repo_address" "$MY_HISTORY_DIR"
            fi
        fi

        echo 'plz select an exist setup or make a new one'
        echo 'here below list the setups already exists'
        ls -F "$MY_HISTORY_DIR" | grep '/'
        read setup
        if [[ "$setup" != '' ]];then
            ln -s "$MY_HISTORY_DIR/$setup/.bash_history.archive" ~/.bash_history.archive
        fi
    }

    _save_history() {
        if [[ "$(_check_dir "$MY_HISTORY_DIR")" == 1 ]]; then
            # there is a threshold for history file, so it might cause 'git command' not always
            # return true
            (cd "$MY_HISTORY_DIR" \
                && git add . \
                && git commit -am save)
        else
            echo 'plz do history_init first'
        fi
    }

    _no_invalid_command_in_history() {
        # https://blog.dhampir.no/content/avoiding-invalid-commands-in-bash-history
        local exit_status=$?
        # If the exit status was 127, the command was not found. Let's remove it from history

        local number=$(history 1 | awk '{print $1}')
        #number=${number%% *}
        if [ -n "$number" ]; then
            if [ $exit_status -eq 127 ] && ([ -z $HISTLASTENTRY ] || [ $HISTLASTENTRY -lt $number ]) ; then
                history -d $number
            else
                HISTLASTENTRY=$number
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
    PROMPT_COMMAND="_no_invalid_command_in_history; history -a; ${PROMPT_COMMAND}"
    shopt -s histappend
    export HISTCONTROL=ignoreboth:ignoredups
    export HISTIGNORE="_no_invalid_command_in_history:[   ]*:&:ag:bg:cat*:cd*:df*:echo*:fg:exit:hh*:history*:git*:ls*:mv*:sbs:src:z"
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
