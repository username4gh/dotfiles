#! /usr/bin/env bash

if _is_linux;then
    if _is_termux;then    
        if ! shopt -oq posix; then        
            if [[ -f /data/data/com.termux/files/usr/share/bash-completion/bash_completion ]]; then            
                . /data/data/com.termux/files/usr/share/bash-completion/bash_completion        
            elif [[ -f /data/data/com.termux/files/etc/bash_completion ]]; then            
                . /etc/bash_completion        
            fi    
        fi
    else
        if ! shopt -oq posix; then
            if [[ -f /usr/share/bash-completion/bash_completion ]]; then
                . /usr/share/bash-completion/bash_completion
            elif [[ -f /etc/bash_completion ]]; then
                . /etc/bash_completion
            fi
        fi
    fi
fi
