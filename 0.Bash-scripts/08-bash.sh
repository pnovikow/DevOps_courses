#!/bin/bash

echo "Введите имя каталога: "
read name_dir
echo "Содержимое каталога:" $name_dir
ls -lah ./$name_dir
