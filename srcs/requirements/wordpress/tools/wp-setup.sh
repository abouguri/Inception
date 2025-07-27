#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
    # Download WordPress core files
    wp core download --allow-root

    # Create wp-config.php
    wp config create --dbname=$MYSQL_DATABASE \
                    --dbuser=$MYSQL_USER \
                    --dbpass=$MYSQL_PASSWORD \
                    --dbhost=mariadb \
                    --allow-root

    # Wait for MariaDB to be ready
    while ! mysqladmin ping -h mariadb --silent; do
        sleep 1
    done

    # Install WordPress
    wp core install --url=$DOMAIN_NAME \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --allow-root

    # Create a regular user
    wp user create $WP_USER $WP_USER_EMAIL \
                --user_pass=$WP_USER_PASSWORD \
                --role=author \
                --allow-root

    # Update permissions
    chown -R www-data:www-data /var/www/html
fi

exec "$@"