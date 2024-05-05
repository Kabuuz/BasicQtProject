cmake_minimum_required(VERSION 3.22)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR/build})

project(BasicQtProject VERSION 1.0)

set(PROJECT_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)

set(BUILD_TESTS OFF CACHE BOOL "Defines if tests should be built")

add_subdirectory(src)

if(BUILD_TESTS)
    message(STATUS "Building tests")
    add_subdirectory(test)
endif()