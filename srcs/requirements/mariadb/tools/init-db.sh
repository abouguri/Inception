#!/bin/bash
set -e

echo "=== MariaDB Init Script Started ==="
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "MYSQL_DATABASE: $MYSQL_DATABASE"
echo "MYSQL_USER: $MYSQL_USER"

# Check if this is a fresh MariaDB installation
# We check for a marker file that indicates setup is complete
if [ ! -f "/var/lib/mysql/.mariadb_setup_complete" ]; then
    echo "=== Setting up custom database and users ==="
    
    # Start MySQL server temporarily for initial setup
    echo "=== Starting MariaDB for initial setup ==="
    mysqld_safe --user=mysql --datadir=/var/lib/mysql --skip-networking --skip-grant-tables &
    
    # Wait for MySQL to start up
    echo "=== Waiting for MariaDB to start ==="
    while ! mysqladmin ping -h localhost --silent; do
        echo "Waiting..."
        sleep 2
    done
    
    # Initial secure setup without password (fresh install)
    echo "=== Setting up initial configuration ==="
    mysql -u root <<-EOSQL
        FLUSH PRIVILEGES;
        SET @@SESSION.SQL_LOG_BIN=0;
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
        CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
        CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
        GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
        FLUSH PRIVILEGES;
        SELECT user, host FROM mysql.user WHERE user='$MYSQL_USER';
EOSQL
    
    echo "=== Database setup completed ==="
    
    # Create marker file to indicate setup is complete
    touch /var/lib/mysql/.mariadb_setup_complete
    
    # Stop the temporary server
    mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
    echo "=== Temporary server stopped ==="
else
    echo "=== MariaDB already initialized (marker file exists) ==="
fi

# Start MySQL server normally
echo "=== Starting MariaDB server normally ==="
exec mysqld_safe --user=mysql --datadir=/var/lib/mysql