FROM golang:1.22.2-alpine

ENV GO111MODULE on
ENV GOPATH /

COPY go.mod .
COPY go.sum .
RUN go mod download && go mod verify
COPY . .

EXPOSE 8080

RUN mkdir /app
RUN go build -o /app/bin .
WORKDIR /app

ENTRYPOINT ["/app/bin"]
