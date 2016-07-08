#! /usr/bin/env bash

#Description create a *.bak

backup() { 
    cp "$1"{,.bak};
}
