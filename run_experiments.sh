#!/bin/bash

file="configurations.csv"

if [[ -f "$file" ]]
then
    i=1 n=0
    while read -r line
        do
            ((n >= i )) && [[ ${line:0:1} == "0" ]] || [[ ${line:0:1} == "i" ]] && python3 module/main.py "$line"
            ((n++))
    done < "$file"
else
    echo "$file not found!"  
fi
