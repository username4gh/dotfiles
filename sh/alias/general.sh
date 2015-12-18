#! /bin/bash

# enable color support of ls and also add handy aliases
if [[ $(_check_command dircolors) == 1 ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [[ $(_check_command nvim) == 1 ]]; then
    alias vi='nvim'
elif [[ $(_check_command vim) == 1 ]]; then
    alias vi='vim'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -v'

alias makescript="fc -rnl | head -1 >"
alias ..='cd ..'
alias ...='cd ../..'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# System info
alias cmount="mount | column -t"

alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p"

# Network
alias websiteget="wget --random-wait -r -p -e robots=off -U mozilla"
alias listen="lsof -P -i -n"
alias netport="netstat -tulanp"
alias ipinfo="curl ifconfig.me && curl ifconfig.me/host"

# Funny
alias busy="cat /dev/urandom | hexdump -C | grep \"ca fe\""

alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias meminfo='free -m -l -t'

# Reload the shell (i.e. invoke as a login shell)
alias myreload="exec $SHELL -l"

