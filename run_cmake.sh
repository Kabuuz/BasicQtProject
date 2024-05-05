#!/bin/bash

if [ $# -ne 2 ] 
then
    echo 'Not enough arguments to run CMake'
    exit 1
fi

BUILD_DIR_ARG=$1
BUILD_TARGET_ARG=$2

IS_CMAKE_MODIFIED=false

if [ -d "./.git" ] ; then
    git_status=$(git status --porcelain)

    while IFS= read -r line; do
        filename=$(echo "$line" | awk '{printf $2}')
        if [[ ($filename == *CMakeLists.txt) ]] ; then
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
    
    BUILD_TESTS_OPTION="buildAppAndTests"
    BUILD_APP_OPTION="buildApp"
    #CMake toolchain file path can change
    #Debug build type:
    CMAKE_TOOLCHAIN_FILE="./build/build/Debug/generators/conan_toolchain.cmake"
    BUILD_TYPE="Debug"
    #Common CMake args
    CMAKE_ARGS="-B $BUILD_DIR_ARG -DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE -DCMAKE_BUILD_TYPE=$BUILD_TYPE"

    if [ $BUILD_TARGET_ARG = $BUILD_APP_OPTION ]
    then
        cmake . $CMAKE_ARGS -DBUILD_TESTS=OFF
    elif [ $BUILD_TARGET_ARG = $BUILD_TESTS_OPTION ]
    then
        cmake . $CMAKE_ARGS -DBUILD_TESTS=ON
    else
        echo 'Could not determine if should be build with test or not'
        echo 'Building with cached configuration'
        cmake . $CMAKE_ARGS
    fi
else
    echo 'CMakeLists.txt not changed'
fi


