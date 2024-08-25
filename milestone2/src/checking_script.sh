#!/bin/bash

make
if [ ! -d "./outputs" ]; then
    mkdir outputs
    mkdir -p outputs/3AC
    mkdir -p outputs/SymTab
fi

for file in ../tests/*.py
do  
    base_name=$(basename "$file" .py)
    ./3ACGenerator -input "$file"
    if [ $? -ne 0 ]; then
        echo "Errors for test case $base_name:"
        echo
    fi
done