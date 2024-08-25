#!/bin/bash

cd src
make
cd ..
if [ ! -d "./outputs" ]; then
  mkdir outputs
fi

for file in ./tests/*.py
do
    base_name=$(basename "$file" .py)
    output=$(./src/myASTGenerator -input "$file" -output "./outputs/$base_name.dot" 2>&1)
    if [ $? -ne 0 ]; then
        echo "Errors for test case $base_name:"
        echo "$output"
        echo
    fi
    output=$(dot -Tpdf "./outputs/$base_name.dot" > "./outputs/$base_name.pdf" 2>&1)
    if [ $? -ne 0 ]; then
        echo "Errors for test case $base_name:"
        echo "$output"
        echo
    fi
done
