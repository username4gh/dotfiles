#! /usr/bin/env bash

alias makescript="fc -rnl | head -1 >"

alias la='ls -a --color=never'
alias lf='ls -F --color=never'
alias lh='ls -alh --color=never'
alias ll='ls -al --color=never'

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

alias sift='sift --git --binary-skip'

alias pg='pythongrep'
alias pf='pythonfind'
