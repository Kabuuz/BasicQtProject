#!/bin/bash

if [ $# -ne 1 ] 
then
    echo 'Not enough arguments to run CMake'
    exit 1
fi

BUILD_DIR=$1

IS_CMAKE_MODIFIED=false

if [ -d "./.git" ] ; then
    git_status=$(git status --porcelain)

    while IFS= read -r line; do
        filename=$(echo "$line" | cut -d' ' -f2-)
        if [[ ($filename == CMakeLists.txt) ]] ; then
            IS_CMAKE_MODIFIED=true
            break
        fi
    done <<< "$git_status"
else
    echo "Cannot determine if CMakeLists.txt has changed"
    exit 0
fi

if $IS_CMAKE_MODIFIED
then
    echo 'CMakeLists.txt changed - reloading CMake'
    cmake . -B $BUILD_DIR
else
    echo 'CMakeLists.txt not changed'
fi


