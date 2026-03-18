# Openfaas Example

[official documents](https://docs.openfaas.com/)

more [information](https://chatgpt.com/share/69b90e5d-8158-8002-800b-7459d017788a) about openfaas 

## installation

### openfaas cli

```
brew install faas-cli
```

### minikube (local kubernetes)

[docs](https://minikube.sigs.k8s.io/docs/start/)

```
brew install minikube
minikube start
```

### helm

```
brew install helm
```

## settings

### set alias

```
vim ~/.zshrc
alias kubectl="minikube kubectl --"
source ~/.zshrc
```

### add openfaas to helm repo

```
helm repo add openfaas https://openfaas.github.io/faas-netes/
helm repo update
```
### create namespace
```
kubectl create namespace openfaas
kubectl create namespace openfaas-fn
```

### install openfaas
```
helm upgrade openfaas openfaas/openfaas \
  --install \
  --namespace openfaas \
  --set functionNamespace=openfaas-fn \
  --set generateBasicAuth=true
```

### check status

```
$ kubectl get pods -n openfaas
NAME                            READY   STATUS              RESTARTS      AGE
alertmanager-7b564bfd57-d4q9b   0/1     ContainerCreating   0             28s
gateway-9c7478969-2shsv         0/2     ContainerCreating   0             28s
nats-86c5cf65f5-rszgh           1/1     Running             0             28s
prometheus-5d4f8f685f-wwcpm     0/1     ContainerCreating   0             28s
queue-worker-797b5d686d-jkmng   1/1     Running             2 (19s ago)   28s

```

### start up gateway

```
kubectl port-forward svc/gateway -n openfaas 8080:8080
```
do not close this temernal

### get password and login

```
kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode
faas-cli login --username admin --password {password}

```

## create openfaas function

### pull template

```
faas-cli template store pull golang-middleware
```

### create function

```
faas-cli new --lang golang-middleware echo
```

## deploy on k8s

### login dockerhub for pushing image
```
docker login
```
cause we use openfaas community edition, we can only deploy image from public registry.


### modify image in stack.yaml

```
image: docker.io/<your_dockerhub_account>/echo:latest
```

### build, push, and deploy
```
faas-cli up -f stack.yaml
```

### check openfaas-fn status
```
kubectl get po -n openfaas-fn
faas-cli list
```

### test openfaas function

```
curl -X POST http://127.0.0.1:8080/function/echo \
     -H "Content-Type: application/json" \
     -d '{"msg":"hello"}'
```
async
```
curl -X POST http://127.0.0.1:8080/async-function/echo \
     -H "Content-Type: application/json" \
     -d '{"msg":"hello"}'
```
