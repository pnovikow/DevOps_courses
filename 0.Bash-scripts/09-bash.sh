#!/bin/bash

echo "Введите имя файла: "
read name_file
echo "Содержимое файла:" $name_file
if [ -e $name_file ]; then
    cat ./$name_file
else
    echo "Файла не существует"
fi
