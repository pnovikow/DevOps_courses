#!/bin/bash

user_choice () {
    while [[ true ]]
    do
        echo "Continue press C/Y or abort press N/A and press Enter"
        read choise
        if [[ "$choise" == "C" || "$choise" == "Y" ]]; then
            echo "We continue"
            copy_dir $source_dir_path $destination_dir_path
            break
        elif [[ "$choise" == "N" || "$choise" == "A" ]]; then
            echo "Abort"
            break
        fi
    done
}

copy_dir () {
    echo "Starting copy"
    cp -r $source_dir_path $destination_dir_path
    echo "Copy succed"
}

source_dir_path=$(sudo find / -type d -name $1)
destination_dir_path=$(sudo find / -type d -name $2)
echo $source_dir_path
echo $destination_dir_path
if [[ "$1" == "$2" || "$source_dir_path" == *"$2"* || "$destination_dir_path" == *"$1"* ]]
then
    echo "Same name"
    exit 1
else
    echo "All right"
fi
source_dir_size=$(du -sb $source_dir_path | cut -f1)
free_space_of_destination=$(df $destination_dir_path | grep / | awk '{ print $4}' | sed 's/%//g')
if [[ "$source_dir_size > $free_space_of_destination" ]] 
then
    copy_dir $source_dir_path $destination_dir_path
else
    echo "Not enough free space"
    user_choice
fi 
