#! /usr/bin/env bash

if [[ ! -d "$HOME/bin" ]];then
    mkdir -p "$HOME/bin"
fi

if [[ ! -d "$MY_WORKSPACE" ]];then
    if [[ "$(uname -s)" == 'Darwin' ]];then
        if [[ "$(id -u)" -ne 0 ]];then
            # in order to avoid issue casuing by HFS+'s default `case-insenstive but case-preserve`
            echo "for Darwin, please use workspace.bash to create a case-senstive partition"
        else 
            # while under root, just use a ordinary directory.
            mkdir -p "$MY_WORKSPACE"
        fi
    else
        # while under linux, just use a ordinary directory.
        mkdir -p "$MY_WORKSPACE"    
    fi
fi

# level-1 directory setup
export MY_BIN="$HOME/bin"
export MY_REPO="$MY_WORKSPACE/repo"

# level-2 directory setup
export MY_I3="$MY_DOTFILES/my-i3"

# level-3 directory setup
export MY_SCRIPT="$MY_I3/script"
export MY_SH="$MY_I3/sh"

# level-4 directory setup
export MY_SH_MODULE="$MY_SH/module"

# reset to avoid issue causing by repeat sourcing
unset PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

export PATH="$MY_SCRIPT:$PATH"

unset PROMPT_COMMAND


_sh_log() {
    if [[ "$#" == 1 ]];then
        local LOG_DIR="$MY_I3/log"
        if [[ -d "$LOG_DIR" ]]; then
            echo "$(date +%Y-%m-%d-%H-%M-%S) $1" >> $LOG_DIR/sh.log
        fi
    else
        echo "Usage: _sh_log content"
    fi
}

_cache_gen() {
    # generate cache.bash, for cache.bash, those 'init.bash' just useless
    if [[ "$(echo $1 | grep init)" == '' ]];then
        echo 'source '"$1" >> "$MY_SH/cache.bash"
    else
        if [[ "$(cat "$1" | grep 'export PATH')" != '' ]];then
            echo "$(cat "$1" | grep 'export PATH')" >> "$MY_SH/cache.bash"
        fi
    fi
}

_cache_clear() {
    if [[ -f "$MY_SH/cache.bash" ]];then
        rm "$MY_SH/cache.bash"
    fi
}

_load_sh_files() {
    if [[ "$#" == 2 ]];then
        local directory="$1"

        local subdirectory="$2"

        local fullPath="${directory}/${subdirectory}"

        if [[ -d "$fullPath" ]];then
            while IFS= read -r -d '' file
            do
                _cache_gen "$file"

                [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file";
            done < <(find "$fullPath" -maxdepth 1 -mindepth 1 -type f -name '*.bash' -print0 | sort -du)
        fi
        unset -v file
    else
        echo "Usage: _load_sh_files baseDirectoryPath subDirectoryName"
    fi
}

if [[ ! -f "$MY_SH/cache.bash" ]];then
    _load_sh_files $MY_SH 'internal'
    _load_sh_files $MY_SH 'path'
    _load_sh_files $MY_SH 'mechanism'
    _load_sh_files $MY_SH 'function'
    _load_sh_files $MY_SH 'alias'
    _load_sh_files $MY_SH 'module'
    _load_sh_files $MY_SH 'completion'
    _load_sh_files $MY_SH 'custom'
else
    source "$MY_SH/cache.bash"
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    shopt -s checkwinsize
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if [[ "$(_check_os)" == "Darwin" ]];then
    export LESSOPEN='| /opt/local/bin/lesspipe.sh %s'
else
    [[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
fi
