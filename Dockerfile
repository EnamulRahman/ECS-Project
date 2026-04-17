FROM golang:1.23-alpine AS backend-builder

WORKDIR /app


RUN apk add --no-cache git


COPY go.mod go.sum ./
RUN go mod download


COPY . .


RUN go build -o /memos


FROM alpine:3.19

WORKDIR /app


RUN apk add --no-cache ca-certificates tzdata libc6-compat


RUN adduser -D -u 1001 appuser


COPY --from=backend-builder /memos /usr/local/bin/memos


USER appuser


EXPOSE 8081


ENTRYPOINT ["memos"]
