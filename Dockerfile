FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o tracker-app main.go parcel.go

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/tracker-app .
COPY --from=builder /app/tracker.db .
CMD ["./tracker-app"]