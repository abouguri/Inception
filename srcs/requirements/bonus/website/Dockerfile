FROM debian:bullseye

# Install nginx only (lightweight for static content)
RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Copy website content
COPY ./content/ /var/www/html/

# Copy nginx configuration
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Remove default nginx site
RUN rm -f /etc/nginx/sites-enabled/default

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 8888

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
