#! /usr/bin/env bash

_module_generate_init_bash() {
    if [[ ! -f "$MY_SH_MODULE/$1/init.bash" ]];then
        cp "$MY_SH/mechanism/module.snippet" "$MY_SH_MODULE/$1/init.bash"
        r -i "$MY_SH_MODULE/$1/init.bash" -b 'module_name' -a "$1"
    fi
}

my_modules_init() {
    if [[ "$#" == 0 ]];then
        # delete old cache.bash, otherwise any change happens to modules likely won't make any difference
        if [[ -f "$MY_SH/cache.bash" ]];then
            rm "$MY_SH/cache.bash"
        fi

        if [[ -f "$MY_SH_MODULE/init.bash" ]];then
            rm -v "$MY_SH_MODULE/init.bash"
        fi

        echo '#! /usr/bin/env bash' > "$MY_SH_MODULE/init.bash"

        while IFS= read -r item;
        do
            echo '_load_sh_files $MY_SH_MODULE '$(_dir_basename $item) >> "$MY_SH_MODULE/init.bash";
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

            _module_generate_init_bash $1 $2
        else
            echo "Usage: _package_init can only be used while current_dir is $MY_SH_MODULE"
        fi
    else
        echo "Usage: my_module_init package_name (y|n)"
        echo "(y|n) for whether this package work under root or not"
    fi
}
