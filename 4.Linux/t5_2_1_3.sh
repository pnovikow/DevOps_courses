#!/bin/bash

user_choice () {
    while [[ true ]]
    do
        echo "Continue press C/Y or abort press N/A and press Enter"
        read choise
        if [[ "$choice" == "C" || "$choice" == "Y" ]]
        then
            echo "we continue"
            archive_dir $source_dir_path $destination_dir_path
            break
        elif [[ "$choice" == "N" || "$choice" == "A" ]]
        then
            echo "abort"
            break
        fi
    done
}

checking_copies () {
    file_basename=$(basename -s .gz $file)
    for (( i=$counter_files_copies; i >= 0; i-- ))
    do
        start_len=$destination_dir_path/$file_basename.
        if [ -f $start_len$i.gz ]
        then   
            let "up_copy=$i+1"
            mv $start_len$i.gz $start_len$up_copy.gz
        fi
    done
    for to_check_file in $(find $destination_dir_path -name "$file_basename*")
    do
        start_len=$destination_dir_path/$file_basename.
        copy_number=${to_check_file:(${#start_len}):(-3)}
        if (( $copy_number >= $counter_files_copies ))
        then
            rm $to_check_file
        fi
    done
}

archive_dir () {
    IFS=$'\n'
    for file in $(find $source_dir_path -type f)
    do  
        if (( archive_way == 1))
        then
            cp "$file" "$destination_dir_path/$(basename $file)".$(date +"%F-%T")
            gzip "$destination_dir_path/$(basename $file)".$(date +"%F-%T")
        else
            checking_copies $file $destination_dir_path $counter_files_copies
            cp "$file" "$destination_dir_path/$(basename $file)".0
            gzip "$destination_dir_path/$(basename $file)".0
        fi
    done
}

while [[ true ]]
do
    echo "Choose way of archivating: 1 - filename + date + time  2 - filename + number"
    read archive_way
    if [[ $archive_way == 1 ]]
    then
        break
    elif [[ $archive_way == 2 ]]
    then
        echo "Write number of files copies"
        read counter_files_copies
        break
    fi
done 
source_dir_path=$(sudo find ~/ -type d -name $1)
destination_dir_path=$(sudo find ~/ -type d -name $2)
if [[ "$1" == "$2" || "$source_dir_path" == *"$2"* || "$destination_dir_path" == *"$1"* ]]
then
    echo "same name"
    exit
else
    echo "all right"
fi
source_dir_size=$(du -sb $source_dir_path | cut -f1)
free_space_of_destination=$(df $destination_dir_path | grep / | awk '{ print $4}' | sed 's/%//g')
if [[ "$source_dir_size < $free_space_of_destination" ]]
then
    archive_dir $source_dir_path $destination_dir_path
else
    echo "Not enough free space"
    user_coise
fi 
