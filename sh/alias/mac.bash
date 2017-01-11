#! /usr/bin/env bash
if [[ "$(_check_os)" == "Darwin" ]]; then

    # IP addresses
    alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
    alias localip="ipconfig getifaddr en0"
    alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

    # Flush Directory Service cache
    alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

    # Clean up LaunchServices to remove duplicates in the “Open With” menu
    alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

    # View HTTP traffic
    alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
    alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

    # Trim new lines and copy to clipboard
    alias c="tr -d '\n' | pbcopy"

    # Recursively delete `.DS_Store` files
    alias cleanup_ds_store="find . -type f -name '*.DS_Store' -ls -delete"

    # Show/hide hidden files in Finder
    alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

    # Hide/show all desktop icons (useful when presenting)
    alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
    alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

    # Disable Spotlight
    alias spotoff="sudo mdutil -a -i off"
    # Enable Spotlight
    alias spoton="sudo mdutil -a -i on"

    alias spotlightoff="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist"

    alias spotlighton="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist"

    # Stuff I never really use but cannot delete either because of http://xkcd.com/530/
    alias stfu="osascript -e 'set volume output muted true'"
    alias pumpitup="osascript -e 'set volume 7'"

    # Kill all the tabs in Chrome to free up memory
    # [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
    alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

    # Lock the screen (when going AFK)
    alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

    alias reloadLaunchepad="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

    # https://github.com/nodejs/node-gyp/issues/569
    alias fix_xcodebuild="sudo xcode-select -s /Applications/Xcode.app/Contents/Developer"

    # http://www.amsys.co.uk/2015/02/delete-keychains-logout/
    alias clear_keychain="rm -Rvf /Users/$USER/Library/Keychains/*"

    alias macd="open -a MacDown"
fi
