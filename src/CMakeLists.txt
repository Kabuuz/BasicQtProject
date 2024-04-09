set(CMAKE_PREFIX_PATH "~/apps/Qt/6.6.1/gcc_64/lib/cmake")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Widgets)

add_executable(basicQtProject
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

target_include_directories(basicQtProject
    PUBLIC
    ${PROJECT_INCLUDE_DIR})

target_link_libraries(basicQtProject Qt6::Widgets)