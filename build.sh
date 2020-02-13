#!/bin/bash
git submodule update --init --recursive
mkdir -p build
cd build
cmake ..
make
