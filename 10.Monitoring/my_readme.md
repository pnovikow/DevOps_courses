# КУБЕР <a name="8x"></a>
Полезные ссылки:

https://habr.com/ru/articles/725640/



https://minikube.sigs.k8s.io/docs/start/


Overview of kubeadm(https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)


Installing Kubernetes with Minikube (official docs https://kubernetes.io/docs/setup/learning-environment/minikube/)

Getting started (official docs https://kubernetes.io/docs/setup/ )
K3s - Lightweight Kubernetes( https://k3s.io/ )
MicroK8s - Zero-ops Kubernetes for workstations and edge / IoT (https://microk8s.io/)


https://ipsoftware.ru/posts-cloud/k8s-quickstart/

https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/

MINIqube 
https://kubernetes.io/ru/docs/tasks/tools/install-minikube/




```
Create a sample deployment and expose it on port 8080:

kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0
kubectl expose deployment hello-minikube --type=NodePort --port=8080
It may take a moment, but your deployment will soon show up when you run:

kubectl get services hello-minikube
The easiest way to access this service is to let minikube launch a web browser for you:

minikube service hello-minikube
Alternatively, use kubectl to forward the port:

kubectl port-forward service/hello-minikube 7080:8080
Tada! Your application is now available at http://localhost:7080/.

```
Высокоуровневое api для взаимодействия c инфрастуктурой

Kubernetes управляет и запускает контейнеры Docker на большом количестве хостов, а так же обеспечивает совместное размещение и репликацию большого количества контейнеров

1) control plane- мастер сервера
2) etcd - распределеное хранилище(сторедж), где храниться информация по кластеру 
(потеряте etcd - потерятее кластер)
ETCD - это распределенная key-value база данных, Эта та самая база данных, поверх которой работает Kubernetes.

3) API - api server. цетральная входная точка для всех комонентов


4) Scheduler - подключается и следит и поределил куда и где поднять поды

5) control manager - сдедит за изменениями (нужно увеличить кол- подов, добавить памяти)

6) cloud-controler - следит за ресурсами и работает с облаком 


    
Простое горизонтальное масштабирование
Мы можем перейти к одной из самых впечатляющих функций Kubernetes - легкому масштабированию. Простейшим способом горизонтального масштабирования является увеличение количества экземпляров сервиса - в случае Kubernetes увеличение количества отсеков с запущенными контейнерами, разумно распределенными по всему кластеру. 





**Namespace** или пространство имен — это абстрактный объект, который логически разграничивает и изолирует ресурсы между подами. Вы можете рассматривать пространство имен как внутренний виртуальный кластер, который поможет вам изолировать проекты 

`kubectl get namespace`

#### Давайте создадим test-namespace.yaml со следующим содержанием:
```
apiVersion: v1
kind: Namespace
metadata:
  name: test
```

```
kubectl apply -f test-namespace.yaml
```


**Pods** или поды — это абстрактный объект в кластере K8S, который состоит из одного или нескольких контейнеров с общим хранилищем и сетевыми ресурсами, а также спецификации для запуска контейнеров.
Это главный объект в кластере, в нем прописаны, какие контейнеры должны быть запущены, количество экземпляров или реплик,

#### Создадим hello.yaml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-hello
  labels:
    app: nginx-hello
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-hello
  template:
    metadata:
      labels:
        app: nginx-hello
    spec:
      containers:
      - name: nginx-hello
        image: nginxdemos/hello
        ports:
        - containerPort: 80

```

```
kubectl apply -f hello.yaml

...узнать иформацию о поде

kubectl get pods -n test
...
NAME        READY   STATUS              RESTARTS   AGE
nginx-hello-75cc4f9fb7-rv556   1/1     Running            0          9s

...проброс порта
kubectl port-forward nginx-hello-75cc4f9fb7-rv556 30080:80 -n test
```


**Service** Service — это абстракция, определяющая набор подов и доступ к ним. Он является объектом REST в API K8S, а службы самого K8S настраивают прокси (iptables, ipvs) на пересылку и фильтрацию трафика только тем контейнерам, которые были выбраны в его селекторе.

```
Kube-proxy — это сетевой прокси-сервер, который работает на каждом узле кластера. Он занимается реализацией виртуальных ip, установкой правил проксирования и фильтрацией трафика.
```





**Helm Chart** - это набор файлов конфигурации Kubernetes, который используется для управления установкой и настройкой приложений в кластере Kubernetes. Helm Chart содержит информацию о приложении, его зависимостях, параметрах конфигурации и других ресурсах Kubernetes, таких как сервисы, репликасеты, поды и т.д.

**Helm** - это пакетный менеджер для Kubernetes, который позволяет легко управлять развертыванием и масштабированием приложений на кластере Kubernetes. Helm использует концепцию "чартов" для описания приложения и его зависимостей, а также для управления параметрами конфигурации и другими настройками.

___








```bash
1) kubectl apply -f first_pod.yaml
2) kubectl expose deployment nginx-flask --type="NodePort" --port 5000
3) minikube service nginx-flask

```
```bash
#kubectl get deployments

NAME          READY   UP-TO-DATE   AVAILABLE   AGE
nginx-flask   1/1     1            1           7m27s

```

```bash
# kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
nginx-flask-56c74c56f-lp2w8   1/1     Running   0          8m7s

```


```bash
# minikube service nginx-flask
|-----------|-------------|-------------|---------------------------|
| NAMESPACE |    NAME     | TARGET PORT |            URL            |
|-----------|-------------|-------------|---------------------------|
| default   | nginx-flask |        5000 | http://192.168.49.2:32561 |
|-----------|-------------|-------------|---------------------------|

```

```bash
# kubectl get services
NAME          TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
kubernetes    ClusterIP      10.96.0.1       <none>        443/TCP          163m
nginx-flask   NodePort    10.104.155.107   <none>        5000:30060/TCP   3m53s

```
## Для Меня: (основные команды)

https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/


### Основные команды

```
kubectl get services -n Имя_неймспейса - выводит все сервисы в пространстве имён

kubectl get pods --all-namespaces - выводит все поды во всех пространств имён

kubectl get pods -o wide - выводит все поды в текущем пространстве имён с подробностями в виде расширенной таблицы

kubectl get pods -n Имя_неймспейса - выводит все поды в пространстве имён
```


```
kubectl apply -f ./my-manifest.yaml - создать ресурсы

kubectl apply -f ./my1.yaml -f ./my2.yaml - создать ресурсы из нескольких файлов

kubectl apply -f ./dir - создать ресурсы из всех файлов манифеста в директории

kubectl apply -f https://K8S.io/manifest - создать ресурсы из URL-адреса


chown nobody:nogroup
kubectl exec POD_NAME -c CONTAINER_NAME /sbin/killall5


kubectl cluster-info


получить описание отсеков
kubectl get pods -o wide
minikube service  --all
kubectl get service -o wide



---------------------------------------------
kubectl get all --all-namespaces


kubectl apply -f svc-namespace.yml
 kubectl apply -f svc-pod-nginx.yml --namespace=testspace
 kubectl get pods -n testspace
kubectl create -f svc-ng-server.yml --namespace=testspace
kubectl get service -n testspace
kubectl describe service nginx-hello -n testspace
kubectl describe pod nginx-hello -n testspace

kubectl run curl --image=curlimages/curl -it sh -n testspace
kubectl exec -it curl  /bin/sh -n testspace

kubectl get pot test -o yaml -n testspace

kubectl delete pv ckan-pv-home --grace-period=0 --force
kubectl patch pv ckan-pv-home -p '{"metadata":{"finalizers":null}}'

kubectl logs -l app=elasticsearch

 увеличим количество экземпляров до трех:
kubectl scale --replicas=3 deployment/time-service
kubectl scale deployment nginx-flask --replicas=0


автоматическое горизонтальное масштабирование, причем ограниченное и по нижней, и по верхней границе
kubectl autoscale deployment/time-service --min=1 --max=3 --cpu-percent=80

Удалить сервис
kubectl delete deployment/time-service


```