# Use Debian bullseye as base
FROM debian:bullseye

# Build argument for domain name
ARG DOMAIN_NAME=localhost

# Install Nginx, OpenSSL, and ping; clean up in same layer
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Create SSL directory and generate self-signed certificates
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=${DOMAIN_NAME}"

# Copy custom Nginx config
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Inform Docker the container listens on port 443
EXPOSE 443

# Run Nginx in foreground mode
CMD ["nginx", "-g", "daemon off;"]