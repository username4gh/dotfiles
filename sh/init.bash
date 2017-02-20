#! /usr/bin/env bash
export MY_BIN="$HOME/bin" # 1. executable 2. does not concerns privacy

export MY_DOTFILES="$HOME/.dotfiles"
export MY_BUNDLED_BIN="$MY_DOTFILES/bin" # 1. executable/does not concerns privacy 2. built-in of this whole setup
export MY_SH="$MY_DOTFILES/sh"
export MY_SH_MODULE="$MY_SH/module"

export MY_DEPENDENCIES="$HOME/.dotfiles_dependencies"
export MY_PRIVATE_BIN="$MY_DEPENDENCIES/bin" # 1. executable 2. concerns privacy 3. will be deleted in cleanup-process.

if [[ ! -d "$MY_BIN" ]];then
    mkdir -p "$MY_BIN"
fi

if [[ ! -d "$MY_DEPENDENCIES" ]];then
    mkdir -p "$MY_DEPENDENCIES"
fi

if [[ ! -d "$MY_PRIVATE_BIN" ]];then
    mkdir -p "$MY_PRIVATE_BIN"
fi

# reset to avoid issue causing by repeat sourcing
unset PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$MY_BUNDLED_BIN:$PATH"
export PATH="$MY_PRIVATE_BIN:$PATH"

unset PROMPT_COMMAND

# for internal function, no `Usage`, only print log
_sh_log() {
    if [[ "$#" == 2 ]];then
        local LOG_DIR="$MY_DOTFILES/log"
        if [[ -d "$LOG_DIR" ]]; then
            echo "$(date +%Y-%m-%d-%H-%M-%S) [$1] : $2" >> $LOG_DIR/sh.log
        fi
    fi
}

_cache_gen() {
    # generate cache.bash, for cache.bash, those 'init.bash' just useless
    if [[ "$(echo $1 | grep init)" == '' ]];then
        # echo '[[ -r '"$file"' ]] && [[ -f '"$file"' ]] && source '"$1" >> "$MY_SH/cache.bash"
        # cut overhead as much as possible, so no checking, if anything wrong, just `rf` and then `rl`
        echo 'source '"$1" >> "$MY_SH/cache.bash"
    else
        if [[ "$(cat "$1" | grep 'export PATH')" != '' ]];then
            echo "$(cat "$1" | grep 'export PATH')" >> "$MY_SH/cache.bash"
        fi
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
        _sh_log "$MY_SH/init.bash"  '_load_sh_files'
    fi
}

# using cache as much as possible
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

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then

    # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # rfc stands for `refresh configuration`
    _rfc() {
        if [[ "$#" == 0 ]];then
            # delete old cache.bash, otherwise any change happens to modules likely won't make any difference
            if [[ -f "$MY_SH/cache.bash" ]];then
                rm "$MY_SH/cache.bash"
            fi

            if [[ -f "$MY_SH_MODULE/init.bash" ]];then
                rm "$MY_SH_MODULE/init.bash"
            fi

            echo '#! /usr/bin/env bash' > "$MY_SH_MODULE/init.bash"

            while IFS= read -r item;
            do
                echo '_load_sh_files $MY_SH_MODULE '${item##*/} >> "$MY_SH_MODULE/init.bash";
            done < <(find "$MY_SH_MODULE" -maxdepth 1 -mindepth 1 -type d)
        fi
    }

    # rlc stands for `reload configuration`
    _rlc() {
        # http://stackoverflow.com/questions/2518127/how-do-i-reload-bashrc-without-logging-out-and-back-in
        # https://www.shell-tips.com/2007/01/10/linux-how-to-reload-or-change-your-current-shell/
        exec $SHELL
    }
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

source "$MY_DOTFILES/.profile"
