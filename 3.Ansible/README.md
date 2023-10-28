# Ansible

#### Запуск:
```
ansible-playbook -i inventory_prod.var site_install.yml
```
#### в файле result.log есть полный вывод playbookа

#### 164.90.165.13-host.ini
```
[ubuntu-s-2vcpu-4gb]
uniqueID=382079728
host_ip:164.90.165.13
host_avtor:ivanlvov
```

1) **common** - установка приложений и crontab
1) **elkdocker** - запуск elk через docker-compose
1) **haproxy** - настройка haproxy
1) **iptables** - запрет на входящие порты 5000 5601 2812
1) **monit** - настройка мониторинга system - docker - haproxy
1) **rsyslog** - отправка логов с haproxy на 500 порт logstash
1) **getinfo** - файл host.ini