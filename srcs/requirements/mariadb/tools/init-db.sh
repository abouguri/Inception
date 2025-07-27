#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialize MySQL data directory
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # Start the MySQL service
    service mariadb start

    # Create database and users
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    # Shut down MySQL safely
    service mariadb stop
fi

# Execute CMD
exec "$@"