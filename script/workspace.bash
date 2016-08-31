#!/bin/bash

if [[ "$(uname -s)" == "Darwin" ]]; then

    # https://gist.github.com/scottsb/479bebe8b4b86bf17e2d
    # ---------------------------------------------------------
    # Customizable Settings
    # ---------------------------------------------------------

    # where to store the sparse-image
    WORKSPACE=${HOME}/.workspace.dmg.sparseimage

    # location where workspace will be mounted
    MOUNTPOINT=${HOME}/workspace

    # name of workspace as visible in Finder
    VOLUME_NAME=workspace

    # volume size
    VOLUME_SIZE=120g

    # ---------------------------------------------------------
    # Functionality
    # ---------------------------------------------------------

    create() {
        hdiutil create -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size ${VOLUME_SIZE} -volname ${VOLUME_NAME} ${WORKSPACE}
    }

    automount() {
        cat << EOF > com.workspace.plist
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
        <key>RunAtLoad</key>
        <true/>
        <key>Label</key>
        <string>com.workspace</string>
        <key>ProgramArguments</key>
        <array>
        <string>hdiutil</string>
        <string>attach</string>
        <string>-notremovable</string>
        <string>-nobrowse</string>
        <string>-mountpoint</string>
        <string>${MOUNTPOINT}</string>
        <string>${WORKSPACE}</string>
        </array>
        </dict>
        </plist>
EOF
        sudo cp com.workspace.plist /Library/LaunchDaemons/com.workspace.plist
    }

    detach() {
        m=$(hdiutil info | grep "${MOUNTPOINT}" | cut -f1)
        if [ ! -z "$m" ]; then
            sudo hdiutil detach $m
        fi
    }

    attach() {
        sudo hdiutil attach -notremovable -nobrowse -mountpoint ${MOUNTPOINT} ${WORKSPACE}
    }

    compact() {
        detach
        hdiutil compact ${WORKSPACE} -batteryallowed
        attach
    }

    help() {
        cat <<EOF
        usage: workspace <command>
        Possible commands:
        create       Initialize case-sensitive volume (only needed first time)
        automount    Configure OS X to mount the volume automatically on restart
        mount        Attach the case-sensitive volume
        unmount      Detach the case-sensitive volume
        compact      Remove any uneeded reserved space in the volume
        help         Display this message
EOF
    }

    invalid() {
        printf "workspace: '$1' is not a valid command.\n\n";
        help
    }

    case "$1" in
        create) create;;
        automount) automount;;
        mount) attach;;
        unmount) detach;;
        compact) compact;;
        help) help;;
        '') help;;
        *) invalid $1;;
    esac
else
    echo "This tool only works on OSX"
fi
