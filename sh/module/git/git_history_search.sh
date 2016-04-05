#! /usr/bin/env sh

# http://stackoverflow.com/questions/2928584/how-to-grep-search-committed-code-in-the-git-history
git_history_search() {
    git grep "$1" $(git rev-list --all)
}