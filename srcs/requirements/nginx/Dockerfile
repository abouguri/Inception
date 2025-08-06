# Use Debian bullseye as base
FROM debian:bullseye

# Install Nginx, OpenSSL, and ping; clean up in same layer
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Create SSL directory and generate self-signed cert
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=abouguri.42.fr"

# Copy custom Nginx config
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Inform Docker the container listens on port 443
EXPOSE 443

# Run Nginx in foreground mode
CMD ["nginx", "-g", "daemon off;"]