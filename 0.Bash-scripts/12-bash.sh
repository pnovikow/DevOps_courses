#!/bin/bash
result=$(grep  -rwls  error /var/log/ | wc -l)
if [ $result -gt 0 ]; then
    echo "Найдено файлов:" $result
else
    echo "Файлы не найдены"
fi
