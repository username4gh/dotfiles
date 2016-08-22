#! /usr/bin/env bash

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

unset manifest_list
unset size
unset max_index

unset flat
unset file_basename
unset keyword
