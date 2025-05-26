FROM debian:buster

# Install required packages
RUN apt-get update && \
    apt-get install -y php7.3-fpm php7.3-mysql curl mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Install WordPress CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configure PHP-FPM
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

# WordPress setup script
COPY tools/setup_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wp.sh

# Create directory for PHP-FPM socket and pid
RUN mkdir -p /run/php

# Working directory
WORKDIR /var/www/html

# Expose port 9000
EXPOSE 9000

# Start WordPress and PHP-FPM
ENTRYPOINT ["setup_wp.sh"]