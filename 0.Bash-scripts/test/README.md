# DevOps_courses

## 0.BASH-scripts

#### 01-bash.sh
Написать скрипт определяющий запущен ли скрипт от имени пользователя root.
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./01-bash.sh 
No. the script runs as user john
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ sudo su root ./01-bash.sh 
YEs.the script runs as user root
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ 
```

#### 02-bash.sh
Написать скрипт, который выводит текущую дату и время в формате:
2023-07-20 12:00:00
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./02-bash.sh 
2023-10-10 14:27:02
```

#### 03-bash.sh
Написать скрипт, который создает новый каталог с именем my_new_dir и переходит в
него.
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./03-bash.sh 
/home/john/work/Itransition/DevOps_courses/0.Bash-scripts/my_new_dir
```

#### 04-bash.sh
Написать скрипт, который копирует файл my_file.txt из каталога ~/ в каталог /tmp
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./04-bash.sh 
ls -la /tmp | grep my_file.txt
-rw-rw-r--  1 john john    0 окт 10 15:08 my_file.txt
```

#### 05-bash.sh
Написать скрипт, который удаляет файл my_file.txt из каталога ~/
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./05-bash.sh 
удалён '/home/john/my_file.txt'
```

#### 06-bash.sh
Написать скрипт, который выводит список файлов в каталоге ~/
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./06-bash.sh 
итого 39M
drwxr-x--- 29 john john 4,0K окт 10 15:10  .
drwxr-xr-x  3 root root 4,0K янв  6  2023  ..
-rw-------  1 john john  51K окт  9 19:42  .bash_history
-rw-r--r--  1 john john  220 янв  6  2023  .bash_logout
```

#### 07-bash.sh
Написать скрипт, который запрашивает у пользователя имя файла и выводит его
содержимое.
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./07-bash.sh 
Введите имя файла: 
tmp.txt
Содержимое файла: tmp.txt
Пример текста из файла
```

#### 08-bash.sh
Написать скрипт, который запрашивает у пользователя имя каталога и выводит
список файлов в нем.
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./08-bash.sh 
Введите имя каталога: 
test
Содержимое каталога: test
итого 12K
drwxrwxr-x 2 john john 4,0K окт 10 15:38 .
drwxrwxr-x 3 john john 4,0K окт 10 15:38 ..
-rw-rw-r-- 1 john john   41 окт 10 15:33 tmp.txt
```


#### 09-bash.sh
Написать скрипт, который запрашивает у пользователя имя файла и выводит его
содержимое. Если файла не существует, вывести сообщение об ошибке.
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./09-bash.sh 
Введите имя файла: 
09-bash.sh
Содержимое файла: 09-bash.sh
#!/bin/bash

echo "Введите имя файла: "
read name_file
echo "Содержимое файла:" $name_file
if [ -e $name_file ]; then
    cat ./$name_file
else
    echo "Файла не существует"
fi
```

#### 10-bash.sh
Написать скрипт, который запрашивает у пользователя имя каталога и выводит
список файлов в нем. Если каталог не существует, вывести сообщение об ошибке
```bash
Введите имя каталога: 
tmp
Содержимое каталога: tmp
каталога не существует
----
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./10-bash.sh 
Введите имя каталога: 
test
Содержимое каталога: test
итого 12K
drwxrwxr-x 2 john john 4,0K окт 10 15:38 .
drwxrwxr-x 3 john john 4,0K окт 10 15:56 ..
-rw-rw-r-- 1 john john   41 окт 10 15:33 tmp.txt

```

#### 11-bash.sh
Написать скрипт, который запрашивает у пользователя имя файла и заменяет все
вхождения строки error строкой warning. Если файла не существует, вывести сообщение
об ошибке
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./11-bash.sh 
Введите имя файла: 
tmp.txt
Содержимое файла: tmp.txt
Oct 10 15:30:01 warning johnlap CRON[11788]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Oct 10 15:30:01 warning johnlap CRON[11788]: pam_unix(cron:session): session closed for user root
Oct 10 15:31:26 warning johnlap cinnamon-screensaver-pam-helper: gkr-pam: unlocked login keyring
```

#### 12-bash.sh
Написать скрипт, который ищет файлы по заданному шаблону: все файлы
содержащие текст error в каталоге с логами /var/log. Если файлы не найдены, вывести
сообщение об ошибке
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ sudo  ./12-bash.sh
Файлы не найдены
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ sudo  ./12-bash.sh
Найдено файлов: 70
```

#### 13-bash.sh
Bash-скрипт для создания менеджера свободного места
```bash
john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./13-bash.sh clear
Удалить кэш apt полностью: y/n
y
2023-10-11.21:05 clean apt cache
[sudo] пароль для john:     
Очистка устаревших логов системного журнала y/n
y
Vacuuming done, freed 0B of archived journals from /var/log/journal/e7d0df732b0649e49e97a4d764308014.
Vacuuming done, freed 0B of archived journals from /run/log/journal.
Vacuuming done, freed 0B of archived journals from /var/log/journal.

john@johnlap:~/work/Itransition/DevOps_courses/0.Bash-scripts$ ./13-bash.sh info
базовая информация о дисках:
2023-10-11.21:06 ERROR использование диска sda3 более чем на 80% Значение 94
2023-10-11.21:06 с диском nvme0n1p3 все ок
```