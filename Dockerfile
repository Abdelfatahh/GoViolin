FROM golang:alpine
# check go version
RUN go version

# Configuring the operating system and other Variables
ENV GOOS=linux
# Since we are running 1.16 GO then 
ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOARCH=amd64

# creating the build directory 
RUN mkdir /build
# Selecting the Working Directory 
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
RUN go mod download

# Copy the code into the container
COPY . . 

# Build the go Application 
RUN go build -o main .
RUN mkdir /dist
WORKDIR /dist

RUN cp /build/main .
# Run on port number 8022
EXPOSE 8022

ENTRYPOINT ["/dist/main"]