#! /usr/bin/env bash

alias makescript="fc -rnl | head -1 >"

alias la='ls -a'
alias lf='ls -F'
alias ll='ls -al'

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

# http://stackoverflow.com/questions/2518127/how-do-i-reload-bashrc-without-logging-out-and-back-in
# https://www.shell-tips.com/2007/01/10/linux-how-to-reload-or-change-your-current-shell/
alias src="exec $SHELL"
