# How to use
## How to run the container alone
Start sample application like below.
```bash
$ docker build -t ktact/sample-app .
$ docker run -p 3000:3000 --name sample-app -it ktact/sample-app
running on: http://localhost:3000/
```

Then, access the application from another terminal like below.
```bash
$ curl http://localhost:3000/
{"message":"Hello, World!"}
```
## How to run the container by Kubernetes
### Prerequisitie
Minikube
### Procedures
Push the container image to DockerHub like below.
```bash
$ docker build -t ktact/sample-app .
$ docker login
$ docker push ktact/sample-app:latest
```
Then, apply the manifest and access the application like below.
```bash
$ kubectl apply -f k8s.yaml
$ minikube service sample-app --url
http://192.168.49.2:30080
$ curl -s http://192.168.49.2:30080
{"message":"Hello, World!"}
```

NOTE: The details of the tunnel(`minikube service <service-name> --url`) is written in [Using minikube service with tunnel](https://minikube.sigs.k8s.io/docs/handbook/accessing/#using-minikube-service-with-tunnel).
