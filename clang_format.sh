#!/bin/bash

function format_file() {
    if [[ ($1 == *.cpp) || ($1 == *.hpp) ]] ; then
        clang-format -style=file -i -assume-filename=.clang-format $1
    fi
}

if [ -d "./.git" ] ; then
    git_status=$(git status --porcelain)

    while IFS= read -r line; do
        filename=$(echo "$line" | awk '{printf $2}')
        format_file $filename
    done <<< "$git_status"
else
    echo "Cannot determine which files have changed"
fi

#check that branch name is correctly printed in terminal