#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root

    while ! mysqladmin ping -h mariadb --silent; do
        sleep 1
    done

    wp config create --dbname=$MYSQL_DATABASE \
                    --dbuser=$MYSQL_USER \
                    --dbpass=$MYSQL_PASSWORD \
                    --dbhost=mariadb \
                    --allow-root

    wp core install --url=https://$DOMAIN_NAME \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --allow-root

    wp user create $WP_USER $WP_USER_EMAIL \
                --user_pass=$WP_USER_PASSWORD \
                --role=author \
                --allow-root

    chown -R www-data:www-data /var/www/html
fi

exec "$@"