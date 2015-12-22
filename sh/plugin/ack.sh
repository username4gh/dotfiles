if [[ ! -f "$HOME/bin/ack" ]];then
    curl -s http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && test -z ~/bin/ack || chmod 0755 ~/bin/ack 
fi
