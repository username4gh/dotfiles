# /bin/bash

export MY_SH_FUNCTION="$MY_SH/function"

_myload_sh_files $MY_SH_FUNCTION 'general'

if [[ "$(_check_os)" == "Darwin" ]];then
    _myload_sh_files $MY_SH_FUNCTION 'mac'
else
    _myload_sh_files $MY_SH_FUNCTION 'linux'
fi

