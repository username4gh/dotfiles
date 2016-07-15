#! /usr/bin/env bash
if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then

    SCM_PROMPT_DIRTY=' ✗'
    SCM_PROMPT_CLEAN=' ✓'
    SCM_PROMPT_PREFIX=' |'
    SCM_PROMPT_SUFFIX='|'
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
        elif which git &> /dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then
            SCM=$SCM_GIT
        elif [[ -d .hg ]]; then
            SCM=$SCM_HG
        elif which hg &> /dev/null && [[ -n "$(hg root 2> /dev/null)" ]]; then
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

        if [[ -n "${status}" ]] && [[ "${status}" != "\n" ]] && [[ -n "$(s -v '^#' <<< "${status}")" ]]; then
            SCM_DIRTY=1
            if [[ "${SCM_GIT_SHOW_DETAILS}" = "true" ]]; then
                local untracked_count
                untracked_count="$(s -c '^\?\? .+' <<< "${status}")"

                local unstaged_count
                unstaged_count="$(s -c '^.[^ ?#] .+' <<< "${status}")"

                local staged_count
                staged_count="$(s -c '^[^ ?#]. .+' <<< "${status}")"

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
            tracking_info="$(s "${SCM_BRANCH}\.\.\." <<< "${status}")"

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
            SCM_BRANCH=$(hg summary 2> /dev/null | s branch: | awk '{print $2}')
        fi

        if [ -f "$HG_ROOT/dirstate" ]; then
            # Mercurial holds various information about the working directory in .hg/dirstate file. More on http://mercurial.selenic.com/wiki/DirState
            SCM_CHANGE=$(hexdump -n 10 -e '1/1 "%02x"' "$HG_ROOT/dirstate" | cut -c-12)
        else
            SCM_CHANGE=$(hg summary 2> /dev/null | s parent: | awk '{print $2}')
        fi
    }

    _git_prompt_info() {
        _git_prompt_vars
        echo -e "$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
    }

    _svn_prompt_info() {
        _svn_prompt_vars
        echo -e "$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
    }

    _hg_prompt_info() {
        _hg_prompt_vars
        echo -e "$SCM_PREFIX$SCM_BRANCH:${SCM_CHANGE#*:}$SCM_STATE$SCM_SUFFIX"
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

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    force_color_prompt=yes

    if [[ -n "$force_color_prompt" ]]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt='yes'
        else
            color_prompt='false'
        fi
    fi

    if [[ "$color_prompt" = yes ]]; then
        PS1="\e[1m\u\e[0m\a \[\e[01;32m\]\w\[\e[00m\]\$(scm_prompt_info '(%s)') \$ "
    else
        PS1="\e[1m\u\e[0m\a w\$(scm_prompt_info '(%s)') \$ "
    fi
    unset color_prompt force_color_prompt

    # make `pwd` as iterm2 tab title
    PROMPT_COMMAND+=' echo -ne "\033]0;${PWD##*/}\007";'
fi
