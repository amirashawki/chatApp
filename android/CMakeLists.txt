

# Sets the minimum version of CMake required to build the native library.
cmake_minimum_required(VERSION 3.10.2)

# Specifies the C++ standard.
set(CMAKE_CXX_STANDARD 17)

# Declares the name of the library and its source files.
add_library(my_native_library SHARED
    native_source_file_1.cpp
    native_source_file_2.cpp
    # Add more source files as needed
)

# Specifies the path to the Flutter Engine source code.
set(FLUTTER_ENGINE_PATH ${CMAKE_SOURCE_DIR}/../flutter)

# Includes the CMake file from the Flutter Engine.
include(${FLUTTER_ENGINE_PATH}/cmake/flutter/CMakeLists.txt)

# Specifies the path to your Dart entrypoint file.
set(FLUTTER_TARGET_PATH ${CMAKE_SOURCE_DIR}/..)

# Builds the Flutter library.
flutter_build_library(my_flutter_library
    # Specifies the Dart entrypoint file.
    ${FLUTTER_TARGET_PATH}/main.dart
)

# Links the Flutter library with the native library.
target_link_libraries(my_native_library
    my_flutter_library
    # Add more libraries as needed
)