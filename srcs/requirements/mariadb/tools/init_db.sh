#!/bin/bash

# Check if database directory is empty
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    # Initialize MariaDB data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB service
    service mysql start

    # Create database and user
    mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    mysql -e "FLUSH PRIVILEGES;"

    # Stop MariaDB service
    service mysql stop
fi

# Start MariaDB in foreground
exec mysqld_safe