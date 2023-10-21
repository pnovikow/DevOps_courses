#2.6 Working with Docker
#2.6.2 install docker for ubuntu amd 64

	follow the instructions: https://docs.docker.com/engine/install/ubuntu/ 

#2.6.3 install nginx 	 

	$ sudo docker pull nginx
	
	$ sudo docker container run --name web_server -d -p 8080:80 nginx

#2.6.4 install mysql

	$ sudo docker pull mysql
	
	$ mkdir datadir
	
	$ sudo docker run --name some-mysql -v datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql

#2.6.5 connect mysql and create new database,user

	$ sudo docker exec -it [CONTAINER ID] mysql -uroot -p
	
	enter password: "my-secret-pw"
	
#2.6.5 enter mysql comands 
	 create database test_docker;
	 
	 CREATE USER 'novyi_polzovatel'@'localhost' IDENTIFIED BY 'parol';
	 
	 FLUSH PRIVILEGES;
	 
	 exit

#2.7 Working with Dockerfile
#2.7.1 create dockerfile

	$ touch Dockerfile

#2.7.2 setting dockerfile and building

	FROM ubuntu:20.04
	
	RUN apt-get update
	
	RUN apt-get install -y ruby-full
	
	$ docker build  test.

#2.7.3 run containter and check version ruby

	$ sudo docker container run -it [IMAGE] or name
	
	$ ruby -v

#2.8 Working with Docker-compose
#2.8.1 install docker-compose in host

	$ sudo docker container run -it [IMAGE] or name
	
	# apt-get install -y curl 
	
	# apt-get install wget 
	
	# curl -fsSL https://get.docker.com/ | sh
	
	# wget -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.29.1/docker-compose-Linux-x86_64
	
	# chmod +x /usr/local/bin/docker-compose
	
	# docker-compose version

#2.8.2 install and run site in Wordporess for docker-compose

	$ sudo wget -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.29.1/docker-compose-Linux-x86_64
	
	$ touch docker-compose.yaml
	
	# setting docker-compose.yaml
	
	$ docker-compose up -d
	
	check http://localhost:8080/
