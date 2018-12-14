h/mechanism/completion.bash! /usr/bin/env bash

if [[ "$(uname -s)" == "Darwin" ]]; then
    if [[ "$#" -eq 2 ]];then
        device=/dev/disk$(diskutil list | pythongrep -i $1 | pythongrep -o '(?<=disk).*?(?=$)')
        echo $device

        if [[ ! -e "$device" ]];then
            echo "cannot find such device"
            exit
        else
            echo "1. umount $device"
            sudo umount $device
        fi

        if ! command -v "ntfs-3g" > /dev/null; then
            echo "plz install ntfs-3g first"
            exit
        else
            echo "2. ntfs-3g $device $2"
            sudo ntfs-3g $device $2
        fi
    else
        echo "Usage: $0 <device_qualifier> <mount_point>"
        echo "Noted: '<>' diamond bracket means the argument is necessitated"
        echo "For device_qualifier, use 'ls /Volumes' to check candidates"
        echo "And for unmount, use 'diskutil unmountDisk' to unmount disk"
    fi
else 
    echo "Only works for Darwin"
fi
