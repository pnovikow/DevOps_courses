# Задача 2.4: Создание и запуск контейнера с веб-приложением в Docker

Описание: Исползовал образ python:3.6-slim, сначала добавляем пакет flask и только потом копируем flask приложение 

запускаем через CMD EXEC

#### Commands
```
docker build -t flask:04 .
docker run  -p 80:5000  --name web_server2 flask:04
```

#### Dockerfile
```
FROM python:3.6-slim

RUN pip install flask
ENV FLASK_APP="server"

COPY server.py /srv/flask_app/server.py
WORKDIR /srv/flask_app

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
```

![This is a alt text.](./screen01.png "This is a sample image.")

# Задача 2.5: Задача: Создание многоконтейнерного приложения с использованием Docker и DockerCompose

Добавил для предыдущего решения веб сервер nginx

nginx проксирует запросы на flask бекенд.

`docker-compose up`

`docker-compose down`

```
version: '3.5'

services:
    web:
      image: nginx
      depends_on:
       - flask_web
      volumes:
       - ./nginx_config.conf:/etc/nginx/conf.d/nginx_config.conf
      ports:
       - "80:8080"
      restart: unless-stopped
      networks:
       - webservices

    flask_web:
      image: flask:04
      restart: unless-stopped
      networks:
       - webservices

networks:
   webservices:

```
