FROM golang:alpine as builder
LABEL maintainer="Thuong Nguyen Nhu <thuongnn1997@gmail.com>"

# Set the current working directory inside the container
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build the Go app
RUN go build -o main .

# -------------------------------

# Start a new stage from scratch
FROM alpine:latest

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage. Observe we also copied the .env file
COPY --from=builder /app/main .
COPY .env .

EXPOSE 8080
CMD ["./main"]