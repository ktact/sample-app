# How to use
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
