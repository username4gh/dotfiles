#!/bin/bash

clean_up_safari() {
    if [ -z '$1' -o ! -d '/Users/$1' ] 
    then 
        useroot=~
    else
        useroot=/Users/$1
    fi

    # Clear Safari History (except for bookmarks).
    /usr/bin/find $useroot/Library/Safari -mindepth 1 -maxdepth 1 -execdir /bin/rm -rf \{\} \;

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

    #Since we modified this as 'root', we need to give it back to the user, or we lose all settings.
    if test ! -z $1 ; then
        chown $1 $useroot/Library/Preferences/com.apple.Safari.* 
    fi
}
