
# Задача 2.6: Знакомство с Kubernetes и Minikube
https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/

Создал в файле свой первый pod. Использую свой образ `johnnybravo6/firs-test:0` из предыдущего задания с flask. 

Командой expose создан сервис, что бы под был доступен из вне



#### Основные команды
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

### подключение к контейнеру
```bash
# kubectl exec -it nginx-flask-56c74c56f-lp2w8 /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@nginx-flask-56c74c56f-lp2w8:/srv/flask_app# ^
```