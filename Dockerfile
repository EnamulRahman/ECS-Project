# FINAL RUNTIME IMAGE

FROM alpine:3.19

WORKDIR /app

# Runtime deps for CGO
RUN apk add --no-cache ca-certificates tzdata libc6-compat

# Create non-root user
RUN adduser -D -u 1001 appuser

# Copy backend binary
COPY --from=backend-builder /memos /usr/local/bin/memos

# Switch to non-root user
USER appuser

# Expose Memos port
EXPOSE 8081

# Start Memos
ENTRYPOINT ["memos"]