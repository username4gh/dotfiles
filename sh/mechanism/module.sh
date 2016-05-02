#! /usr/bin/env sh

my_modules_init() {
    if [[ "$#" == 0 ]];then
        if [[ -f "$MY_SH_MODULE/init.sh" ]];then
            rm -v "$MY_SH_MODULE/init.sh"
        fi

        while IFS= read -r item;
        do
            echo '_my_load_sh_files $MY_SH_MODULE '$(_dir_basename $item) >> "$MY_SH_MODULE/init.sh";
        done < <(find "$MY_SH_MODULE" -maxdepth 1 -mindepth 1 -type d)
    else
        echo "Usage: my_modules_init"
    fi
}

my_module_init() {
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
        echo "Usage: my_module_init package_name (y|n)"
        echo "(y|n) for whether this package work under root or not"
    fi
}
