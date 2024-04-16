#!/bin/bash

conan install . --output-folder=build/release --build=missing -s build_type=Release
cd build/release
cmake ../.. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build .
