#!/bin/bash

count=1
if [[ $# == 0 ]];
then
    echo "No parameters"
    exit
else
    while [ -n "$1" ]
    do
        echo "Parameter #$count = $1"
        count=$(( $count + 1 ))
        shift
    done
fi
