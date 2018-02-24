#!/bin/bash

clear_up_safari() {
    #
    # Copy/paste this command and point it at wherever you put this script
    # sudo defaults write com.apple.loginwindow LogoutHook "/Users/pingnak/scripts/privacy.sh"
    #
    # To be complete, Safari->Preferences->AutoFill clear all of the checkmarks (it won't remember passwords and forms).
    # If you use 'Time Machine', you should exclude all of these folders, too.
    #
    # Script runs as root, so make sure this file is protected from casual modification.
    #

    if [ -z '$1' -o ! -d '/Users/$1' ] 
    then 
        useroot=~
    else
        useroot=/Users/$1
    fi

    # Clear Safari History (except for bookmarks).
    /usr/bin/find $useroot/Library/Safari/ -not -name Bookmarks.plist -execdir /bin/rm -rf \{\} \;

    # Forget cookies
    /bin/rm -f $useroot/Library/Cookies/*

    # Forget whatever this stuff is
    /bin/rm -rf $useroot/Library/Caches/com.apple.Safari

    # Forget Flash plugin persistent 'Shared Objects' settings 
    /bin/rm -rf $useroot/Library/Preferences/Macromedia/Flash\ Player/#SharedObjects

    # Forget another copy of history
    /bin/rm -rf $useroot/Library/Caches/Metadata/Safari/History

    # Forget search history embedded in Safari preferences
    /usr/bin/defaults write $useroot/Library/Preferences/com.apple.Safari RecentSearchStrings '( )'
    #defaults delete ~/Library/Preferences/com.apple.Safari RecentSearchStrings
    #/usr/bin/defaults write $useroot/Library/Preferences/com.apple.Safari RecentSearchStrings '( "None of your business." )'

    #Since we modified this as 'root', we need to give it back to the user, or we lose all settings.
    if test ! -z $1 ; then
        chown $1 $useroot/Library/Preferences/com.apple.Safari.* 
    fi

    # If only this worked...
    #defaults write ~/Library/Preferences/com.apple.Safari PrivateBrowsingEnabled 1

    # Add any additional clean-up here.
}
