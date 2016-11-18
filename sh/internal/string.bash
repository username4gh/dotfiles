#! /usr/bin/env bash

# http://www.tldp.org/LDP/abs/html/string-manipulation.html

_string_contains() {
    if [[ "$#" == 2 ]];then
        string="$1"
        substring="$2"
        if test "${string#*$substring}" != "$string"
        then
            return 1    # $substring is in $string
        else
            return 0    # $substring is not in $string
        fi
    else
        echo "_string_contains error"
    fi
}

_string_trim() {
    echo "$(echo -e "${1}" | tr -d '[[:space:]]')"
}

_string_replace_front_end() {
    string="$1"
    substring="$2"
    replacement="$3"
    echo "${string/#$substring/$replacement}"
}

_string_replace_back_end() {
    string="$1"
    substring="$2"
    replacement="$3"
    echo "${string/%$substring/$replacement}"
}

_string_replace_first() {
    if [[ "$#" == 3 ]];then
        input="$1"
        old="$2"
        new="$3"
        echo "${input/$old/$new}" 
    fi
}

_string_replace_all() {
    if [[ "$#" == 3 ]];then
        input="$1"
        old="$2"
        new="$3"
        echo "${input//$old/$new}" 
    fi
}

_string_size() {
    if [[ "$#" == 1 ]];then
        input="$1"
        echo "${#input}"
    fi
}

_string_index_of_character() {
    input="$1"
    size="${#input}"

    for ((i = 0; i < size; i++));
    do
        [[ "${input:$i:1}" =~ "$2" ]] && echo "$i" && return
    done

    echo "-1"
}

_string_substring() {
    if [[ "$#" == 2 ]];then
        input="$1"
        position="$2"
        echo "${input:$position}"
    fi

    if [[ "$#" == 3 ]];then
        input="$1"
        position="$2"
        length="$3"
        echo "${input:$position:$length}"
    fi
}

_string_remove() {
    input="$1"
    substring="$2"
    echo "${string#$substring}"
}

_string_remove_greedy() {
    input="$1"
    substring="$2"
    echo "${string##$substring}"
}

_string_remove_from_back() {
    input="$1"
    substring="$2"
    echo "${input%substring}"
}

_string_remove_from_back_greedy() {
    input="$1"
    substring="$2"
    echo "${input%%substring}"
}
