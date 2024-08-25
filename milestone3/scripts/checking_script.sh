#!/bin/bash

cd ..
if [ ! -d "./outputs" ]; then
    mkdir outputs
    mkdir -p outputs/3AC
    mkdir -p outputs/SymTab
    mkdir -p outputs/Error
    mkdir -p outputs/x86
fi
cd src

make
for file in ../tests/*.py
do  
    base_name=$(basename "$file" .py)
    ./python_compiler -input "$file" 2> ../outputs/Error/$base_name.txt
    if [ $? -ne 0 ]; then
        echo "Errors for test case $base_name: in ../outputs/Error/$base_name.txt"
        echo
        exit 1
    fi
    gcc -g -c ../outputs/x86/$base_name.s -o ../outputs/x86/$base_name.o
    gcc ../outputs/x86/$base_name.o -o ../outputs/x86/$base_name
    echo -e "\n"
    echo "Output for test case $base_name:"
    ./../outputs/x86/$base_name 
    echo -e "\n"
    rm ../outputs/x86/$base_name.o
    rm ../outputs/x86/$base_name
done
rm lex.yy.c
rm parser.tab.c
rm parser.tab.h
rm parser.output
rm python_compiler