# /bin/bash

# If not running interactively, don't do anything 
# this line has to be placed at this front-pos, 
# otherwise the rsync will not work
case $- in
    *i*) ;;
    *) return;;
esac

if [[ ! -d "$HOME/bin" ]];then
    mkdir -p "$HOME/bin"
fi

# level-1 directory setup
export MY_BIN="$HOME/bin"
export MY_REPO="$HOME/repo"

# level-2 directory setup
export MY_I3="$MY_REPO/my-i3"

# level-3 directory setup
export MY_SH="$MY_I3/sh"

export MY_SH_MODULE="$MY_SH/module"

_my_sh_log() {
    if [[ "$#" == 1 ]];then
        local LOG_DIR="$MY_I3/log"
        if [[ -d "$LOG_DIR" ]]; then
            echo "$(date +%Y-%m-%d-%H-%M) $1" >> $LOG_DIR/sh.log
        fi
    else
        echo "Usage: _my_sh_log content"
    fi
}

_myload_sh_files() {
    if [[ "$#" == 2 ]];then
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
    else
        echo "Usage: _myload_sh_files directory subdirectory"
    fi
}

_myload_sh_files $MY_SH 'internal'
_myload_sh_files $MY_SH 'path'
_myload_sh_files $MY_SH 'mechanism'
_myload_sh_files $MY_SH 'function'
_myload_sh_files $MY_SH 'alias'
_myload_sh_files $MY_SH 'module'
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
