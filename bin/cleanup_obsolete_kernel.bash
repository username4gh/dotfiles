#! /usr/bin/env bash

# linux-headers-4.4.0-36-generic
# linux-headers-4.4.0-36
# linux-image-extra-4.4.0-36-generic
# linux-image-4.4.0-36-generic

if [[ "$(uname -s)" == 'Linux' ]];then
    line=$(dpkg -l | grep 'linux' | awk '{print $2}' | grep ".*headers-[0-9].*-generic" | sort | wc -l)
    while IFS= read -r item;
    do
        version=$(echo "$item" | grep -Po '(?<=linux-headers-).*?(?=-generic)')
        echo "delete $version"
        sudo dpkg --purge linux-headers-$version-generic && \
            sudo dpkg --purge linux-headers-$version && \
            sudo dpkg --purge linux-image-extra-$version-generic && \
            sudo dpkg --purge linux-image-$version

    done< <(dpkg -l | grep 'linux' | awk '{print $2}' | grep ".*headers-[0-9].*-generic" | sort | head -n "$((line-1))")
else
    echo "only one kernel left!"
fi
