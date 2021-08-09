#2.9  Working with Kubernetes

#2.9.1 install minikube

	# install kubectl
	
	$ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
	
	$ chmod +x ./kubectl
	
	$ sudo mv ./kubectl /usr/local/bin/kubectl
	
	$ kubectl version --client
	
	#install minikube 
	
	$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
	  && chmod +x minikube
 
#2.9.2 create namespace for deploy simple web program

	$ minikube start --vm-driver=virtualbox
	
	$ minikube status
	
	$ kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
	
	$ kubectl expose deployment web --type=NodePort --port=8080
	
#2.9.3 create deployments file for install with Kubernetes

	#create and setting file pod-nginx.yaml
	
	$ kubectl create -f pod-nginx.yaml

#2.9.4 install ingress

	$ minikube addons enable ingress

#2.9.5 create and install ingress rule

	#setting example.ingress.yaml
