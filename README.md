# GoViolin

GoViolin is a web app written in Go that helps with violin practice.

Currently hosted on Heroku at https://go-violin.herokuapp.com/

GoViolin allows practice over both 1 and 2 octaves.

# Go installation

If you are new to go I suggest that you check the installation guide, due to my experience:

- You need to install go from [GO Docs](https://golang.org/doc/install).
- Then Clone this project using the command `git clone https://github.com/Abdelfatahh/GoViolin`
- Now all you need is to build and run the project.
- To build the project use `go mod init`
- The result will be **\*go: creating new go.mod: module github.com/Rosalita/GoViolin
  go: copying requirements from vendor/vendor.json
  go: to add module requirements and sums:
  go mod tidy**
- `go build -o goviolin.o .`

That was the very first step to see the application running on your local machine.

# Docker Installation

- To run docker on your machine you first need to install it :

```bash
sudo apt-get update
```

```bash
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

```bash
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
```

```bash
sudo apt-get update
```

```bash
sudo apt-get install -y docker-engine
```

```bash
sudo systemctl enable docker
```

# Jenkins Installation

There are different ways to install jenkins but lets go through this one..

```bash
sudo mkdir -p /var/jenkins_home
```

```bash
sudo chown -R 1000:1000 /var/jenkins_home/
```

```bash
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home --name jenkins -d jenkins/jenkins:lts
```

Head to https://localhost:8080/

```bash
cat /var/jenkins_home/secrets/initialAdminPassword
```

A screen with “Create First admin User prompt” will appear. You will need to enter a username, password, full name and email address.

# Jenkins Plugins

- Once you are in the jenkins homepage create a freestyle project.
- Then go to manage jenkins then manage plugins and install `CloudBees Docker Build and Publish plugin` and `Go plugin`

#

Now Head to your go project and create the Dockerfile using the command

```bash
nano Dockerfile
```

and add the following code to it.

```docker
FROM golang:1.16 AS builder
WORKDIR /go/src/app
COPY . .
RUN export CGO_ENABLED=0 && go mod init && go build -o main .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /go/src/app .
EXPOSE 8080
CMD ["./main"]
```

then build the docker image using the command

```bash
docker build -t goviolin .
```

then run the image on your localhost to see it running

```bash
docker run --publish 8999:8080 goviolin:latest
```
