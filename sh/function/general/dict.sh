#! /usr/bin/env sh

# http://www.commandlinefu.com/commands/browse
dict() { 
    curl -s dict://dict.org/d:$1 | perl -ne 's/\r//; last if /^\.$/; print if /^151/../^250/'; 
}
