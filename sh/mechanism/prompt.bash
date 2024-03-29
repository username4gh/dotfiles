#! /usr/bin/env bash

if _is_not_root;then
    if _is_bash;then

        SCM_PROMPT_DIRTY=' ✗'
        SCM_PROMPT_CLEAN=' ✓'
        SCM_PROMPT_PREFIX='|'
        SCM_PROMPT_SUFFIX='| '
        SCM_BRANCH_PREFIX=''
        SCM_TAG_PREFIX='tag:'
        SCM_DETACHED_PREFIX='detached:'
        SCM_BRANCH_TRACK_PREFIX=' → '
        SCM_BRANCH_GONE_PREFIX=' ⇢ '

        SCM_GIT_SHOW_DETAILS=${SCM_GIT_SHOW_DETAILS:=true}
        SCM_GIT_SHOW_REMOTE_INFO=${SCM_GIT_SHOW_REMOTE_INFO:=auto}
        SCM_GIT_IGNORE_UNTRACKED=${SCM_GIT_IGNORE_UNTRACKED:=false}

        SCM_GIT='git'
        SCM_GIT_CHAR='±'
        SCM_GIT_DETACHED_CHAR='⌿'
        SCM_GIT_AHEAD_CHAR="↑"
        SCM_GIT_BEHIND_CHAR="↓"
        SCM_GIT_UNTRACKED_CHAR="?:"
        SCM_GIT_UNSTAGED_CHAR="U:"
        SCM_GIT_STAGED_CHAR="S:"

        SCM_HG='hg'
        SCM_HG_CHAR='☿'

        SCM_SVN='svn'
        SCM_SVN_CHAR='⑆'

        SCM_NONE='NONE'
        SCM_NONE_CHAR='○'

        _scm() {
            if [[ -f .git/HEAD ]]; then
                SCM=$SCM_GIT
            elif command -v git &> /dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then
                SCM=$SCM_GIT
            elif [[ -d .hg ]]; then
                SCM=$SCM_HG
            elif command -v hg &> /dev/null && [[ -n "$(hg root 2> /dev/null)" ]]; then
                SCM=$SCM_HG
            elif [[ -d .svn ]]; then
                SCM=$SCM_SVN
            else
                SCM=$SCM_NONE
            fi
        }

        _scm_prompt_char() {
            if [[ -z $SCM ]]; then
                _scm;
            fi

            if [[ "$SCM" == "$SCM_GIT" ]]; then
                SCM_CHAR=$SCM_GIT_CHAR
            elif [[ "$SCM" == "$SCM_HG" ]]; then
                SCM_CHAR=$SCM_HG_CHAR
            elif [[ "$SCM" == "$SCM_SVN" ]]; then
                SCM_CHAR=$SCM_SVN_CHAR
            else
                SCM_CHAR=$SCM_NONE_CHAR
            fi
        }

        _git_prompt_vars() {
            local details
            details=''

            SCM_STATE=${GIT_PROMPT_CLEAN:-$SCM_PROMPT_CLEAN}
            local git_status_flags
            [[ "${SCM_GIT_IGNORE_UNTRACKED}" = "true" ]] && git_status_flags='-uno'

            local status
            status="$(git status -b --porcelain ${git_status_flags} 2> /dev/null || git status --porcelain ${git_status_flags} 2> /dev/null)"

            if [[ -n "${status}" ]] && [[ "${status}" != "\n" ]] && [[ -n "$(pythongrep -v '^#' <<< "${status}")" ]]; then
                SCM_DIRTY=1
                if [[ "${SCM_GIT_SHOW_DETAILS}" = "true" ]]; then
                    local untracked_count
                    untracked_count="$(pythongrep -c '^\?\? .+' <<< "${status}")"

                    local unstaged_count
                    unstaged_count="$(pythongrep -c '^.[^ ?#] .+' <<< "${status}")"

                    local staged_count
                    staged_count="$(pythongrep -c '^[^ ?#]. .+' <<< "${status}")"

                    [[ "${staged_count}" -gt 0 ]] && details+=" ${SCM_GIT_STAGED_CHAR}${staged_count}" && SCM_DIRTY=3
                    [[ "${unstaged_count}" -gt 0 ]] && details+=" ${SCM_GIT_UNSTAGED_CHAR}${unstaged_count}" && SCM_DIRTY=2
                    [[ "${untracked_count}" -gt 0 ]] && details+=" ${SCM_GIT_UNTRACKED_CHAR}${untracked_count}" && SCM_DIRTY=1
                fi
                SCM_STATE=${GIT_PROMPT_DIRTY:-$SCM_PROMPT_DIRTY}
            fi

            SCM_CHANGE=$(git rev-parse --short HEAD 2>/dev/null)

            local ref
            ref=$(git symbolic-ref -q HEAD 2> /dev/null)

            if [[ -n "$ref" ]]; then
                SCM_BRANCH=${SCM_BRANCH_PREFIX}${ref#refs/heads/}
                local tracking_info
                tracking_info="$(pythongrep "${SCM_BRANCH}\.\.\." <<< "${status}")"

                if [[ -n "${tracking_info}" ]]; then
                    local branch_gone
                    [[ "${tracking_info}" =~ .+\[gone\]$ ]] && branch_gone="true"

                    tracking_info=${tracking_info#\#\# ${SCM_BRANCH}...}
                    tracking_info=${tracking_info% [*}
                    local remote_name
                    remote_name=${tracking_info%%/*}
                    local remote_branch
                    remote_branch=${tracking_info#${remote_name}/}
                    local remote_info
                    remote_info=""
                    local num_remotes
                    num_remotes=$(git remote | wc -l 2> /dev/null)

                    local same_branch_name
                    [[ "${SCM_BRANCH}" = "${remote_branch}" ]] && same_branch_name=true
                    if ([[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "auto" ]] && [[ "${num_remotes}" -ge 2 ]]) || [[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "true" ]]; then
                        remote_info="${remote_name}"
                        [[ "${same_branch_name}" != "true" ]] && remote_info+="/${remote_branch}"
                    elif [[ ${same_branch_name} != "true" ]]; then
                        remote_info="${remote_branch}"
                    fi

                    if [[ -n "${remote_info}" ]];then
                        if [[ "${branch_gone}" = "true" ]]; then
                            SCM_BRANCH+="${SCM_BRANCH_GONE_PREFIX}${remote_info}"
                        else
                            SCM_BRANCH+="${SCM_BRANCH_TRACK_PREFIX}${remote_info}"
                        fi
                    fi
                fi
                SCM_GIT_DETACHED="false"
            else
                local detached_prefix
                detached_prefix=""

                ref=$(git describe --tags --exact-match 2> /dev/null)
                if [[ -n "$ref" ]]; then
                    detached_prefix=${SCM_TAG_PREFIX}
                else
                    ref=$(git describe --contains --all HEAD 2> /dev/null)
                    ref=${ref#remotes/}
                    [[ -z "$ref" ]] && ref=${SCM_CHANGE}
                    detached_prefix=${SCM_DETACHED_PREFIX}
                fi
                SCM_BRANCH=${detached_prefix}${ref}
                SCM_GIT_DETACHED="true"
            fi

            local ahead_re
            ahead_re='.+ahead ([0-9]+).+'

            local behind_re
            behind_re='.+behind ([0-9]+).+'
            [[ "${status}" =~ ${ahead_re} ]] && SCM_BRANCH+=" ${SCM_GIT_AHEAD_CHAR}${BASH_REMATCH[1]}"
            [[ "${status}" =~ ${behind_re} ]] && SCM_BRANCH+=" ${SCM_GIT_BEHIND_CHAR}${BASH_REMATCH[1]}"

            local stash_count
            stash_count="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"

            [[ "${stash_count}" -gt 0 ]] && SCM_BRANCH+=" {${stash_count}}"

            SCM_BRANCH+=${details}

            SCM_PREFIX=${GIT_PROMPT_PREFIX:-$SCM_PROMPT_PREFIX}
            SCM_SUFFIX=${GIT_PROMPT_SUFFIX:-$SCM_PROMPT_SUFFIX}
        }

        _svn_prompt_vars() {
            if [[ -n $(svn status 2> /dev/null) ]]; then
                SCM_DIRTY=1
                SCM_STATE=${SVN_PROMPT_DIRTY:-$SCM_PROMPT_DIRTY}
            else
                SCM_DIRTY=0
                SCM_STATE=${SVN_PROMPT_CLEAN:-$SCM_PROMPT_CLEAN}
            fi
            SCM_PREFIX=${SVN_PROMPT_PREFIX:-$SCM_PROMPT_PREFIX}
            SCM_SUFFIX=${SVN_PROMPT_SUFFIX:-$SCM_PROMPT_SUFFIX}
            SCM_BRANCH=$(svn info 2> /dev/null | awk -F/ '/^URL:/ { for (i=0; i<=NF; i++) { if ($i == "branches" || $i == "tags" ) { print $(i+1); break }; if ($i == "trunk") { print $i; break } } }') || return
            SCM_CHANGE=$(svn info 2> /dev/null | sed -ne 's#^Revision: ##p' )
        }

        # this functions returns absolute location of .hg directory if one exists
        # It starts in the current directory and moves its way up until it hits /.
        # If we get to / then no Mercurial repository was found.
        # Example:
        # - lets say we cd into ~/Projects/Foo/Bar
        # - .hg is located in ~/Projects/Foo/.hg
        # - get_hg_root starts at ~/Projects/Foo/Bar and sees that there is no .hg directory, so then it goes into ~/Projects/Foo
        _get_hg_root() {
            local CURRENT_DIR
            CURRENT_DIR=$(pwd)

            while [ "$CURRENT_DIR" != "/" ]; do
                if [ -d "$CURRENT_DIR/.hg" ]; then
                    echo "$CURRENT_DIR/.hg"
                    return
                fi

                CURRENT_DIR=$(dirname "$CURRENT_DIR")
            done
        }

        _hg_prompt_vars() {
            if [[ -n "$(hg status 2> /dev/null)" ]]; then
                SCM_DIRTY=1
                SCM_STATE=${HG_PROMPT_DIRTY:-$SCM_PROMPT_DIRTY}
            else
                SCM_DIRTY=0
                SCM_STATE=${HG_PROMPT_CLEAN:-$SCM_PROMPT_CLEAN}
            fi
            SCM_PREFIX=${HG_PROMPT_PREFIX:-$SCM_PROMPT_PREFIX}
            SCM_SUFFIX=${HG_PROMPT_SUFFIX:-$SCM_PROMPT_SUFFIX}

            HG_ROOT=$(_get_hg_root)

            if [ -f "$HG_ROOT/branch" ]; then
                # Mercurial holds it's current branch in .hg/branch file
                SCM_BRANCH=$(cat "$HG_ROOT/branch")
            else
                SCM_BRANCH=$(hg summary 2> /dev/null | pythongrep branch: | awk '{print $2}')
            fi

            if [ -f "$HG_ROOT/dirstate" ]; then
                # Mercurial holds various information about the working directory in .hg/dirstate file. More on http://mercurial.selenic.com/wiki/DirState
                SCM_CHANGE=$(hexdump -n 10 -e '1/1 "%02x"' "$HG_ROOT/dirstate" | cut -c-12)
            else
                SCM_CHANGE=$(hg summary 2> /dev/null | pythongrep parent: | awk '{print $2}')
            fi
        }

        _git_prompt_info() {
            _git_prompt_vars
            echo -ne "$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
        }

        _svn_prompt_info() {
            _svn_prompt_vars
            echo -ne "$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
        }

        _hg_prompt_info() {
            _hg_prompt_vars
            echo -ne "$SCM_PREFIX$SCM_BRANCH:${SCM_CHANGE#*:}$SCM_STATE$SCM_SUFFIX"
        }

        scm_prompt_info() {
            _scm
            _scm_prompt_char
            SCM_DIRTY=0
            SCM_STATE=''
            [[ "$SCM" == "$SCM_GIT" ]] && _git_prompt_info && return
            [[ "$SCM" == "$SCM_HG" ]] && _hg_prompt_info && return
            [[ "$SCM" == "$SCM_SVN" ]] && _svn_prompt_info && return
        }

        prompt_switch_between_light_and_heavy() {
            # the scm-xx fucntion can cause serious performance issue when encounters huge codebase, so we provide this to easily switch off this functionality
            if [[ -f "$MY_DOTFILES_RESOURCES/SCM_PROMPT_INFO_ON" ]];then
                rm "$MY_DOTFILES_RESOURCES/SCM_PROMPT_INFO_ON"
            else
                touch "$MY_DOTFILES_RESOURCES/SCM_PROMPT_INFO_ON"
            fi
        }

        _prompt_info() {
            if [[ -f "$MY_DOTFILES_RESOURCES/SCM_PROMPT_INFO_ON" ]];then
                scm_prompt_info "$@"
            fi
        }

        # http://stackoverflow.com/questions/10594786/bash-prompt-history-issue
        # http://superuser.com/questions/232721/how-to-avoid-tilde-in-bash-prompt
        # http://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history
        # http://misc.flogisoft.com/bash/tip_colors_and_formatting
        if _is_darwin; then
            if [[ ! -z "$MY_CURRENT_PACKAGE_MANAGER" ]];then
                PS1="[\\j] [\${MY_CURRENT_PACKAGE_MANAGER}] \\u \\[\e[32m\\]\${PWD}\\[\e[0m\\] \$(_prompt_info '(%s)')\\$ "
            else
                PS1="[\\j] \\u \\[\e[32m\\]\${PWD}\\[\e[0m\\] \$(_prompt_info '(%s)')\\$ "
            fi
        else
            PS1="[\\j] \\u \\[\e[32m\\]\${PWD}\\[\e[0m\\] \$(_prompt_info '(%s)')\\$ "
        fi

        # make `pwd` as iterm2 tab title
        PROMPT_COMMAND+=' echo -ne "\033]0;${PWD##*/}\007";'
    fi
else
    # http://stackoverflow.com/questions/10594786/bash-prompt-history-issue
    # http://superuser.com/questions/232721/how-to-avoid-tilde-in-bash-prompt
    # http://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history
    if _is_darwin; then
        if [[ ! -z "$MY_CURRENT_PACKAGE_MANAGER" ]];then
            PS1="[\\j] [\${MY_CURRENT_PACKAGE_MANAGER}] \\u \\[\e[32m\\]\${PWD}\\[\e[0m\\] \\$ "
        else
            PS1="[\\j] \\u \\[\e[32m\\]\${PWD}\\[\e[0m\\] \\$ "
        fi
    else
        PS1="[\\j] \\u \\[\e[32m\\]\${PWD}\\[\e[0m\\] \\$ "
    fi


    # make `pwd` as iterm2 tab title
    PROMPT_COMMAND+=' echo -ne "\033]0;${PWD##*/}\007";'
fi
