FROM golang:alpine as builder
RUN apk add -U --no-cache ca-certificates
RUN mkdir -p /app/chishell/
WORKDIR /app/chishell/
ADD . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o chishell sshd.go

FROM scratch
WORKDIR /

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/chishell/chishell /
COPY id_rsa /id_rsa
COPY keypair.pub /keypair.pub
