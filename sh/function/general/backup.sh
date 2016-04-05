#! /usr/bin/env sh

#Description create a *.bak

backup() { 
    cp "$1"{,.bak};
}
