#! /bin/bash

# enable color support of ls and also add handy aliases
if [[ $(_check_command 'dircolors') == 1 ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias makescript="fc -rnl | head -1 >"

# System info
alias cmount="mount | column -t"

# Network
alias websiteget="wget --random-wait -r -p -e robots=off -U mozilla"
alias listen="lsof -P -i -n"
alias netport="netstat -tulanp"
alias ipinfo="curl ifconfig.me && curl ifconfig.me/host"

# Funny
alias busy="cat /dev/urandom | hexdump -C | grep \"ca fe\""

alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# Reload the shell (i.e. invoke as a login shell)
if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    alias src="exec $SHELL -l"
fi