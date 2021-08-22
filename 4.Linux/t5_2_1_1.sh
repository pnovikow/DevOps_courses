#!/bin/bash

base_path=$1
max_depth=$2
file_size=$3
iter_count=$4

for (( i=0; i<$iter_count; i++))
do
    path=$base_path
    deep=$(( $RANDOM%$max_depth ))
    random_name=$(tr -dc A-Za-z0-9_ < /dev/urandom | head -c 8 | xargs)
    for (( x=0; x<deep; x++ ))
    do
        random_name=$(tr -dc A-Za-z0-9_ < /dev/urandom | head -c 8 | xargs)
        #echo $deep
        path=$path/$random_name/ 
    done
    if (( $RANDOM%2 )) ; then
        mkdir -p $path
        fallocate -l $file_size $path/$(tr -dc A-Za-z0-9_ < /dev/urandom | head -c 8 | xargs).file 
    else
        mkdir -p $path/$random_name
    fi
done 
