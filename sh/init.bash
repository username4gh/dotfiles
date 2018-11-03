#! /usr/bin/env bash
export MY_BIN="$HOME/bin" # 1. executable 2. does not concerns privacy

export MY_DOTFILES="$HOME/.dotfiles"
export MY_BUNDLED_BIN="$MY_DOTFILES/bin" # 1. executable/does not concerns privacy 2. built-in of this whole setup
export MY_SH="$MY_DOTFILES/sh"
export MY_SH_MODULE="$MY_SH/module"
export MY_LOG_DIR="$MY_DOTFILES/log"

export MY_DOTFILES_RESOURCES="$HOME/.dotfiles_resources"
export MY_PRIVATE_BIN="$MY_DOTFILES_RESOURCES/bin" # 1. executable 2. concerns privacy 3. will be deleted in cleanup-process.

if [[ ! -d "$MY_BIN" ]];then
    mkdir -p "$MY_BIN"
fi

if [[ ! -d "$MY_DOTFILES_RESOURCES" ]];then
    mkdir -p "$MY_DOTFILES_RESOURCES"
fi

if [[ ! -d "$MY_PRIVATE_BIN" ]];then
    mkdir -p "$MY_PRIVATE_BIN"
fi

# unset to avoid issue caused by repeatly sourcing .bashrc
unset PROMPT_COMMAND

#export PATH="$PATH_HOLDER"
export PATH="$MY_BUNDLED_BIN:$PATH"
export PATH="$MY_PRIVATE_BIN:$PATH"

# for internal function, no `Usage`, only print log
_sh_log() {
    # $1 -- TAG
    # $2 -- content
    # $3 -- log file
    if [[ -d "$MY_LOG_DIR" ]]; then
        if [[ "$#" == 3 ]];then
            echo "$(date +%Y-%m-%d-%H-%M-%S) [$1] : $2" >> "$MY_LOG_DIR/$3.log"
        fi
    fi
}

_sh_log_enable() {
    if [[ ! -d "$MY_LOG_DIR" ]];then
        mkdir -p "$MY_LOG_DIR"
    fi
}

_sh_log_disable() {
    if [[ -d "$MY_LOG_DIR" ]];then
        rm -rf "$MY_LOG_DIR"
    fi
}

_cache_gen() {
    local OUTPUT_FILE="$MY_SH/cache.bash"

    echo "# $1" >> "$OUTPUT_FILE"

    if [[ "$1" =~ 'init.bash' ]];then
        # <MODULE>/init.bash
        while IFS= read -r line
        do
            [[ "$line" =~ 'export PATH' ]] && echo "$line" >> "$OUTPUT_FILE"
        done < <(cat "$1")
    else

        # echo '[[ -r '"$file"' ]] && [[ -f '"$file"' ]] && source '"$1" >> "$MY_SH/cache.bash"
        # cut overhead as much as possible, so no checking for existence of each file, if anything goes wrong, just `_rfc` and then `_rlc`

        #while IFS= read -r line
        #do
        #    if [[ "$line" =~ '#! /usr/bin/env bash' ]];then
        #        # ignore the shebang line
        #        continue
        #    fi

        #    if [[ "$line" =~ '_annotation_completion_write[:space:]' ]];then
        #        # ignore the completion annotation line
        #        continue
        #    fi

        #    if [[ "$line" =~ '_completion_setup[:space:]' ]];then
        #        continue
        #    fi

        #    echo "$line" >> "$OUTPUT_FILE"
        #done < <(cat "$1")
        cat "$1" >> "$OUTPUT_FILE"
    fi

    # append a new line to prevent issue
    echo -e "\n" >> "$OUTPUT_FILE"
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

                [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
            done < <(find "$fullPath" -maxdepth 1 -mindepth 1 -type f -name '*.bash' -print0 | sort -du)
        fi
        unset -v file
    fi
}

# using cache as much as possible
if [[ ! -f "$MY_SH/cache.bash" ]];then
    _load_sh_files $MY_SH 'internal'
    _load_sh_files $MY_SH 'mechanism'
    _load_sh_files $MY_SH 'path'
    _load_sh_files $MY_SH 'runtime'
    _load_sh_files $MY_SH 'function'
    _load_sh_files $MY_SH 'alias'
    _load_sh_files $MY_SH 'module'
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
if _is_darwin;then
    export LESSOPEN='| /opt/local/bin/lesspipe.sh %s'
else
    [[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
fi

source "$MY_DOTFILES/.profile"

# deduplicate to avoid issue caused by sourcing repeatly
export PATH="$(clean_path_variable)" # hold the path for later use
