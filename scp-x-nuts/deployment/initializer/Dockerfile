FROM golang:1.22.2-alpine

ENV GO111MODULE on
ENV GOPATH /

COPY go.mod .
COPY main.go .

EXPOSE 8080

RUN go build -o /app main.go

ENTRYPOINT ["/app"]
