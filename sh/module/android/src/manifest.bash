#! /usr/bin/env bash

# this function depends on that all Activity class are named in '*Activity' form
_manifest_check_activity() {
    manifest_list=($(find . -iname *AndroidManifest.xml | s -v build))
    size=${#manifest_list[@]}
    max_index=$(($size-1))
    #echo $manifest
    while IFS= read -r activity
    do
        # reset flag
        unset flag
        file_basename=${activity##*/}
        keyword=${file_basename%\.*}
        for ((i = 0; i < size; i++));
        do
            if [[ ! -z "$(s -f ${manifest_list[$i]} $keyword)" ]];then
                flag='exist'
                continue
            else
                if [[ -z "$flag" ]];then
                    if [[ "$i" -eq "$max_index" ]];then
                        echo $keyword
                    fi
                fi
            fi
        done
    done < <(find . -iname *Activity.java)
}
