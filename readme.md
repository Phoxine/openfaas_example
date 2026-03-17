# Openfaas Example

[official documents](https://docs.openfaas.com/)

more [information](https://chatgpt.com/share/69b90e5d-8158-8002-800b-7459d017788a) about openfaas 

## install faas-cli

```
brew install faas-cli
```

## pull template

```
faas-cli template store pull golang-middleware
```

## create function

```
faas-cli new --lang golang-middleware echo
```

## build image and run container locally

```
faas-cli build
docker run -p 8080:8080 echo:latest
```

## call openfaas funciton

```
curl -X POST http://localhost:8080 \
  -H "Content-Type: application/json" \
  -d '{"name":"test"}'
```

## deploy function


```
faas-cli up
```

 - faas-cli build - build an image into the local Docker library
 - faas-cli push - push that image to a remote container registry
 - faas-cli deploy - deploy your function into a cluster

The `faas-cli up` command automates all of the above in a single command.
