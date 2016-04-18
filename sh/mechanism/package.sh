#! /usr/bin/env sh

my_package_init() {
    if [[ "$#" == 2 ]];then
        local current_dir=$(pwd)
        if [[ "$current_dir" == "$MY_SH_MODULE" ]];then
            mkdir -p "$MY_SH_MODULE/$1"
            mkdir -p "$MY_SH_MODULE/$1/src"
            if [[ ! -f "$MY_SH_MODULE/$1/init.sh" ]];then
                echo '#! /usr/bin/env sh' >> "$MY_SH_MODULE/$1/init.sh"
                echo "" >> "$MY_SH_MODULE/$1/init.sh"

                if [[ "$2" == 'n' ]];then
                    echo 'if [[ $(whoami) != root ]];then' >> "$MY_SH_MODULE/$1/init.sh"
                fi

                echo ' _my_load_sh_files $MY_SH_MODULE/'"$1" 'src' >> "$MY_SH_MODULE/$1/init.sh"

                if [[ "$2" == 'n' ]];then
                    echo 'fi' >> "$MY_SH_MODULE/$1/init.sh"
                fi
            fi
        else
            echo "Usage: _package_init can only be used while current_dir is $MY_SH_MODULE"
        fi
    else
        echo "Usage: _package_init package_name (y|n)"
        echo "(y|n) for whether this package work under root or not"
    fi
}
