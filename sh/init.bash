#! /usr/bin/env bash

# hardcode to avoid 
_pythonfind() {
    "$MY_BUNDLED_BIN/pythonfind" "$@"
}

# using cache as much as possible
if _is_file_exist "$MY_SH/cache.bash";then
    _load_sh_files() {
        return
    }
else 
    _cache_gen() {
        local OUTPUT_FILE="$MY_SH/cache.bash"

        cat "$1" >> "$OUTPUT_FILE"
        
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
                done < <(_pythonfind --root-dir "$fullPath" --type f --case-insensitive --print0 '^.*\.bash$')
                # done < <(pythonfind --root-dir "$fullPath" --type f --case-insensitive --print0 '^.*\.bash$' | sort -du) 
                # because the 'sort -du' does not work well on termux 
                # it do not separate matches with a null byte in output, for now we just avoid using it
            fi
            unset -v file
        fi
    }

    _load_sh_files $MY_SH 'internal'
    _load_sh_files $MY_SH 'mechanism'
    _load_sh_files $MY_SH 'path'
    _load_sh_files $MY_SH 'runtime'
    _load_sh_files $MY_SH 'function'
    _load_sh_files $MY_SH 'alias'
    _load_sh_files $MY_SH 'module'
    _load_sh_files $MY_SH 'custom'
    
    unset -f _load_sh_files

    _load_sh_files() {
        # to fix #66 completely, we might need re-work the module design
        # for a quick fix, we just make this _load_sh_files a empty function
        return
    }
fi

source "$MY_SH/cache.bash"

if _is_bash;then

    # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # rfc stands for `refresh configuration`
    _rfc() {
        if [[ "$#" == 0 ]];then
            # delete old cache.bash, otherwise any change happens to modules likely won't make any difference
            if _is_file_exist "$MY_SH/cache.bash";then
                rm "$MY_SH/cache.bash"
            fi
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
    LESSPIPE_SH="$(which lesspipe.sh)"
    if _is_file_exist "$LESSPIPE_SH";then
        export LESSOPEN='| '"$LESSPIPE_SH"' %s'
    fi
else
    [[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
fi

source "$MY_DOTFILES/.profile"

# here we make sure the MY_PRIVATE_BIN stays at the beginning of 'PATH' str
export PATH="$MY_PRIVATE_BIN:$PATH"

# deduplicate to avoid issue caused by sourcing repeatly
export PATH="$(clean_path_variable)"
