#! /usr/bin/env sh

# Run `dig` and display the most useful info
digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}