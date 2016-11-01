#! /usr/bin/env bash

if [[ "$(uname -s)" == "Darwin" ]]; then
    if [[ "$#" -eq 2 ]];then
        device=/dev/disk$(diskutil list | s -i $1 | s -o '(?<=disk).*?(?=$)')
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
            echo "ntfs-3g $device $2"
            sudo ntfs-3g $device $2
        fi
    else
        echo "Usage: command device_qualifier mount_point"
        echo "For device_qualifier, use `diskutil list` to check candidates"
        echo "Example: command QPTP /mnt"
        echo "And for unmount, use `diskutil unmount` to unmount partition first, then use `diskutil unmountDisk` to unmount disk"
    fi
else 
    echo "Only works for Darwin"
fi
