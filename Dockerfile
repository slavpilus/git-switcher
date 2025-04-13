FROM alpine:latest

RUN apk update && apk add --no-cache \
  git \
  openssh \
  bash \
  curl

# Create necessary directories
RUN mkdir -p /root/.ssh

WORKDIR /git-workspace

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
