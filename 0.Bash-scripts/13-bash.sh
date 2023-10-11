#!/bin/bash

arg_main="$1"
date=$(date "+%Y-%m-%d.%H:%M")

if [ $arg_main == "" ]
then
    echo $date "менеджера свободного места v0.2 Введите параметры:"
    echo "info - для отображения базовой информации о дисках"
    echo "clear - очистка диска" 
    exit 0
fi


function f_get_disk_info {
    command_output=$(lsblk -rf -o NAME,FSUSE%,MOUNTPOINT | grep mnt)
    readarray -t lines <<< "$command_output"

}
function f_info {
    # Теперь можно обрабатывать элементы массива
    for line in "${lines[@]}"; do
        #echo "Строка: $line"
        test2=$(echo $line |  awk '{print $1}' | sed 's/%//g')
        test3=$(echo $line |  awk '{print $2}' | sed 's/%//g')
        #echo $test2 $test3
        if [[ $test3 -gt 80 ]]; then
            result=$(echo "$date ERROR использование диска $test2 более чем на 80% Значение $test3"  | tee -a ./disk_script.log)
            echo $result

        else
            result=$(echo "$date с диском $test2 все ок"  | tee -a ./disk_script.log)
            #f_add_log $result
            echo $result
        fi
    done
   
}






case $arg_main in
    info)
        echo "базовая информация о дисках:"
        f_get_disk_info
        f_info
        ;;
    clear)
        echo "Удалить кэш apt полностью: y/n"
        read var
        case $var in
            y)
                echo $date "clean apt cache" | tee -a ./disk_script.log
                sudo apt clean | tee -a ./disk_script.log
                ;;
            n)
                echo "Галя, у нас Отмена" | tee -a ./disk_script.log
                ;;
        esac
        echo "Очистка устаревших логов системного журнала y/n"
        read var2
        case $var2 in
            y)
                sudo journalctl --vacuum-time=3d  | tee -a ./disk_script.log
                sudo find /var/log/ -type f -name "*log" -mtime +30 -delete | tee -a ./disk_script.log
                ;;
            n)
                echo "Галя, у нас Отмена"  | tee -a ./disk_script.log
                ;;
        esac
        ;;
esac

