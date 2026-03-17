# Openfaas Example

[official documents](https://docs.openfaas.com/)

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
docker run echo:latest
```

## deploy function


```
faas-cli up
```

 - faas-cli build - build an image into the local Docker library
 - faas-cli push - push that image to a remote container registry
 - faas-cli deploy - deploy your function into a cluster

The `faas-cli up` command automates all of the above in a single command.
