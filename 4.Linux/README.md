# Категория Nginx/Apache (1-6)
Извиняюсь, тут ничего не понял что и куда должно проксировать в итоге

Попробую через пару дней еще раз понять

# Категория Linux 7

#### Создаем пустой бинарный файл
```
dd if=/dev/zero of=partition1.img bs=1024 count=1000000
dd if=/dev/zero of=partition2.img bs=1024 count=1000000
dd if=/dev/zero of=partition3.img bs=1024 count=1000000
dd if=/dev/zero of=partition4.img bs=1024 count=1000000
```
#### Образ привязывается к loop-устройству
```
sudo losetup /dev/loop0 partition1.img
sudo losetup /dev/loop1 partition2.img
sudo losetup /dev/loop2 partition3.img
sudo losetup /dev/loop3 partition4.img
```
#### Создаем тома pvcreate
```
sudo pvcreate /dev/loop0
sudo pvcreate /dev/loop1
sudo pvcreate /dev/loop2
sudo pvcreate /dev/loop3
```

#### Создаем тома vgcreate
```
sudo vgcreate test /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
```


#### Создаем lvm том
```
sudo lvcreate -L 3,5G -n lv01 test
```
#### sudo lvdisplay
```
  --- Logical volume ---
  LV Path                /dev/test/lv01
  LV Name                lv01
  VG Name                test
  LV UUID                KRrvId-AcIZ-g6cB-G9Op-EtYX-IGnZ-QtJ27i
  LV Write Access        read/write
  LV Creation host, time johnlap, 2023-10-29 21:28:29 +0400
  LV Status              available
  # open                 0
  LV Size                3,50 GiB
  Current LE             896
  Segments               4
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0

```

# Категория Jenkins (1-8)
Тут пришлось сделать по-своему. Я не понял зачем использовать такой сложный способ https://medium.com/@dperny/forwarding-the-docker-socket-over-ssh-e6567cfab160
(Forwarding the Docker Socket over SSH) + там в примере еще используется docker swarm. 

Есть очень красивый вариант через поключение к сокету docker c помощью `tls + docker context`

ну или используя ssh-ключи и docker context, что я и сделал

#### на мастер ноде настроен docker context
```
docker context create --docker host=ssh://jenkins@172.31.20.128 --description="Remote engine" my-remote-engine

docker context use my-remote-engine
```

```
jenkins@ip-172-31-28-63:~$ docker context ls
NAME                 DESCRIPTION                               DOCKER ENDPOINT               ERROR
default              Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   
my-remote-engine *   Remote engine                             ssh://jenkins@172.31.20.128 
```

#### pipline срипт
```groovy
#!/usr/bin/env groovy

pipeline {
    agent {
        label 'master || built-in'
    }
    stages {

        stage('Docker_prepare') {
            steps {
                echo 'switching to docker context'
                sh 'docker context use my-remote-engine'
            }
        }
        stage('Docker_run') {
            steps {
                echo 'Starting...'
                sh 'docker run hello-world'
            }
        }
    }

}
```

