#!/bin/bash

# Wait for MariaDB to be ready
while ! mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB..."
    sleep 1
done

# Check if WordPress is already installed
if [ ! -f "/var/www/html/wp-config.php" ]; then
    # Download WordPress
    wp core download --allow-root

    # Create WordPress configuration
    wp config create \
        --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb

    # Install WordPress
    wp core install \
        --allow-root \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    # Create additional user
    wp user create $WP_USER $WP_USER_EMAIL \
        --allow-root \
        --role=author \
        --user_pass=$WP_USER_PASSWORD
fi

# Set proper permissions
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
exec php-fpm7.3 -F