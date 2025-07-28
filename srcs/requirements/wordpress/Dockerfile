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

# Optional: Set up locale
RUN apt-get update && apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN apt-get update && apt-get install -y iputils-ping && rm -rf /var/lib/apt/lists/*

# Configure php-fpm to listen on network
RUN mkdir -p /run/php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install WordPress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set working directory
WORKDIR /var/www/html

# COPY ./tools/wp-config.php /var/www/html/wp-config.php

# # Set permissions (in Dockerfile or entrypoint)
# RUN chown www-data:www-data /var/www/html/wp-config.php \
#     && chmod 640 /var/www/html/wp-config.php

# (Optional) Copy a static wp-config.php if you want
# COPY ./tools/wp-config.php /var/www/html/wp-config.php

# Copy WordPress setup script
COPY ./tools/wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh

# Set permissions for web directory
RUN chown -R www-data:www-data /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM and set up WordPress
ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]
CMD ["php-fpm7.4", "-F"]