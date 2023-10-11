#!/bin/bash

echo "Введите имя файла: "
read name_file
echo "Содержимое файла:" $name_file
cat ./$name_file
