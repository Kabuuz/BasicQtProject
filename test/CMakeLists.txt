find_package(GTest REQUIRED)

add_executable(basicQtProjectTest
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

message(STATUS "AAAAAA")
message(STATUS "${CMAKE_INCLUDE_PATH}")
message(STATUS "AAAAAA")

target_include_directories(basicQtProject
    PUBLIC
    ${CMAKE_INCLUDE_PATH})

target_link_libraries(basicQtProjectTest gtest::gtest)
