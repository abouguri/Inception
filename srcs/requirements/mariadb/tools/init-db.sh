#!/bin/bash
set -e

# Ensure required environment variables are set
: "${MYSQL_DATABASE:?MYSQL_DATABASE not set}"
: "${MYSQL_USER:?MYSQL_USER not set}"
: "${MYSQL_PASSWORD:?MYSQL_PASSWORD not set}"
: "${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD not set}"

# Ensure /run/mysqld exists with correct permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize database if not already present
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # Start MariaDB server in the background
    mysqld_safe --user=mysql &
    
    # Wait for MariaDB to be available
    while ! mysqladmin ping --silent; do
        sleep 1
    done

    # Create database and users
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    # Shutdown MariaDB after setup (ignore error if already stopped)
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown || true
fi

# Execute CMD (e.g., mysqld)
exec "$@"