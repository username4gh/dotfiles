#! /usr/bin/env bash

# http://stevelorek.com/how-to-shrink-a-git-repository.html

_git_find_large_files() {
    # set the internal field spereator to line break, so that we can iterate easily over the verify-pack output
    IFS=$'\n';

    # list all objects including their size, sort by size, take top 10
    objects=$(git verify-pack -v .git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head -10)

    echo "All sizes are in kB. The pack column is the size of the object, compressed, inside the pack file."

    output="size,pack,SHA,location"
    for y in $objects
    do
        # extract the size in bytes
        size=$((`echo $y | cut -f 5 -d ' '`/1024))
        # extract the compressed size in bytes
        compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
        # extract the SHA
        sha=`echo $y | cut -f 1 -d ' '`
        # find the objects location in the repository tree
        other=`git rev-list --all --objects | grep $sha`
        #lineBreak=`echo -e "\n"`
        output="${output}\n${size},${compressedSize},${other}"
    done

    echo -e $output | column -t -s ', '
}

_git_clean_the_files() {
    echo "git filter-branch --tag-name-filter cat --index-filter 'git rm -r --cached --ignore-unmatch filename'  --prune-empty -f -- --all"
}

_git_reclaim_space() {
    echo "Reclaim space"

    echo "1. rm -rf .git/refs/original/"
    rm -rf .git/refs/original/

    echo "2. git reflog expire --expire=now --all"
    git reflog expire --expire=now --all

    echo "3. git gc --prune=now"
    git gc --prune=now

    echo "4. git gc --aggressive --prune=now"
    git gc --aggressive --prune=now
}

_git_push_origin_force_all() {
    # Push the cleaned repository
    git push origin --force --all
}

_git_push_origin_force_tags() {
    # push the newly-rewritten tags
    git push origin --force --tags
}
