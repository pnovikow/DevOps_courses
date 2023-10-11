#!/bin/bash

echo "Введите имя каталога: "
read name_dir
echo "Содержимое каталога:" $name_dir
if [ -d ./$name_dir ]; then
    ls -lah ./$name_dir
else
    echo "каталога не существует"
fi
