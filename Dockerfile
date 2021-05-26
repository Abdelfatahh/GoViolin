FROM golang:1.16
# creating the build directory 
RUN mkdir /build
# Selecting the Working Directory 
WORKDIR /build
COPY . . 
# Configuring the operating system and other Variables
ENV GOOS=linux
# Since we are running 1.16 GO then 
ENV GO111MODULE=on
ENV CGO_ENABLED=0
# Build the go Application 
RUN go build -o goviolin-isntabug.o . 
RUN mkdir /app
WORKDIR /app
RUN cp /build/goviolin-instabug.o .
# Run on port number 8080
EXPOSE 8080
ENTRYPOINT ["./goviolin-instabug.o"]