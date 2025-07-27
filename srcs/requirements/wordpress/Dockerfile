FROM debian:bullseye

# Install dependencies and MariaDB client
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-gd \
    php7.4-xml \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-curl \
    wget \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Configure php-fpm to listen on network
RUN mkdir -p /run/php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install WordPress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set working directory
WORKDIR /var/www/html

# Copy WordPress setup script
COPY ./tools/wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM and set up WordPress
ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]
CMD ["php-fpm7.4", "-F"]