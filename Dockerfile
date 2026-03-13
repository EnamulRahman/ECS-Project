
# FRONTEND BUILD (PNPM)

FROM node:20-alpine AS frontend-builder

RUN corepack enable

WORKDIR /src/memos/web

# Copy dependency files
COPY memos/web/package.json memos/web/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# Copy frontend source
COPY memos/web ./

# Build frontend
RUN pnpm build



# BACKEND BUILD (Go)


FROM golang:1.23-alpine AS backend-builder
ENV GOTOOLCHAIN=auto

WORKDIR /src/memos

# Required for CGO
RUN apk add --no-cache git build-base

# Copy Go mod files
COPY memos/go.mod memos/go.sum ./
RUN go mod download

# Single backend copy
COPY memos ./

# Copy frontend dist into backend expected path
COPY --from=frontend-builder \
    /src/memos/web/dist \
    /src/memos/server/router/frontend/dist

# Build Go binary
RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w" -o /memos ./cmd/memos


# FINAL RUNTIME IMAGE

FROM alpine:3.19

WORKDIR /app

# Runtime deps for CGO
RUN apk add --no-cache ca-certificates tzdata libc6-compat

# Copy backend binary
COPY --from=backend-builder /memos /usr/local/bin/memos

# Expose Memos port
EXPOSE 8081

# Start Memos
ENTRYPOINT ["memos"]