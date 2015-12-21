# /bin/bash

# If not running interactively, don't do anything 
# this line has to be placed at this front-pos, 
# otherwise the rsync will not work
case $- in
    *i*) ;;
    *) return;;
esac

export MY_CONFIG="$HOME/repo/my-i3"

export MY_SH="$MY_CONFIG/sh"

_my_sh_log() {
    local LOG_DIR="$MY_CONFIG/log"
    if [[ -d "$LOG_DIR" ]]; then
        echo "$(date +%Y-%m-%d-%H-%M) $1" >> $LOG_DIR/sh.log
    fi
}

_myload_sh_files() {
    local directory="$1"

    local subdirectory="$2"
    
    local fullPath="${directory}/${subdirectory}"

    if [[ -d "$fullPath" ]];then
        while IFS= read -r -d '' file
        do
            _my_sh_log "load $file"
            [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file";
        done < <(find "$fullPath" -maxdepth 1 -name '*.sh' -print0 | sort -du)
    fi
    unset -v file
}

_myload_sh_files $MY_SH 'internal'
_myload_sh_files $MY_SH 'path'
_myload_sh_files $MY_SH 'function'
_myload_sh_files $MY_SH 'alias'
_myload_sh_files $MY_SH 'plugin'
_myload_sh_files $MY_SH 'custom'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    shopt -s checkwinsize
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
