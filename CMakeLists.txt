# Minimum CMake version
cmake_minimum_required(VERSION 3.31)

# Project declaration with version and languages
project(audiofx-cpp VERSION 1.0 LANGUAGES C CXX)

# Modern policy for compiler flag handling
cmake_policy(SET CMP0063 NEW)

# C++17 configuration
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# C11 configuration
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Default build type if not specified
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE RelWithDebInfo)
endif()

# Strict compiler warnings
add_compile_options(
    "$<$<COMPILE_LANGUAGE:CXX>:-Wall;-Wextra;-Wpedantic;-Werror>"
    "$<$<COMPILE_LANGUAGE:C>:-Wall;-Wextra;-Wpedantic;-Werror>"
)

# Packages
find_package(PkgConfig REQUIRED)
pkg_search_module(SNDFILE REQUIRED sndfile)

# Create executable target
add_executable(audiofx-cpp src/main.cpp)
target_include_directories(audiofx-cpp PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${SNDFILE_INCLUDE_DIRS}
)
target_link_libraries(audiofx-cpp PRIVATE ${SNDFILE_LIBRARIES})
