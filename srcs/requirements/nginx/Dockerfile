# Use Debian bullseye as base
FROM debian:bullseye

# Install Nginx, OpenSSL, and ping; clean up in same layer
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Create SSL directory (certificates will be mounted from host)
RUN mkdir -p /etc/nginx/ssl

# Copy custom Nginx config
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Inform Docker the container listens on port 443
EXPOSE 443

# Run Nginx in foreground mode
CMD ["nginx", "-g", "daemon off;"]