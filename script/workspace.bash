#!/bin/bash

if [[ "$(uname -s)" == "Darwin" ]]; then

    # stolen from https://gist.github.com/scottsb/479bebe8b4b86bf17e2d

    # ---------------------------------------------------------
    # Customizable Settings
    # ---------------------------------------------------------

    # where to store the sparse-image
    WORKSPACE=${HOME}/.workspace.dmg.sparseimage

    # location where workspace will be mounted
    # if we do not mount under the '/', it may cause some ambiguous problem(compatibility)
    MOUNTPOINT=/workspace

    # name of workspace as visible in Finder
    VOLUME_NAME=workspace

    # volume size
    VOLUME_SIZE=120G

    # ---------------------------------------------------------
    # Functionality
    # ---------------------------------------------------------

    create() {
        hdiutil create -type SPARSE -layout NONE -fs 'Case-sensitive Journaled HFS+' -size ${VOLUME_SIZE} -nospotlight -volname ${VOLUME_NAME} ${WORKSPACE}
    }

    detach() {
        m=$(hdiutil info | grep "${MOUNTPOINT}" | cut -f1)
        echo $m
        if [ ! -z "$m" ]; then
            sudo hdiutil detach $m
        fi
    }

    attach() {
        sudo hdiutil attach -notremovable -nobrowse -mountpoint ${MOUNTPOINT} ${WORKSPACE}
    }

    help() {
        cat <<EOF
        usage: workspace <command>
        Possible commands:
        create       Initialize case-sensitive volume (only needed first time)
        mount        Attach the case-sensitive volume
        unmount      Detach the case-sensitive volume
        help         Display this message
EOF
    }

    invalid() {
        printf "workspace: '$1' is not a valid command.\n\n";
        help
    }

    case "$1" in
        create) create;;
        mount) attach;;
        unmount) detach;;
        help) help;;
        '') help;;
        *) invalid $1;;
    esac
else
    echo "This tool only works on OSX"
fi
