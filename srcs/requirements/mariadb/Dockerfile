FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*


RUN apt-get update && apt-get install -y iputils-ping && rm -rf /var/lib/apt/lists/*


# Configure MariaDB to listen on all interfaces
RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Ensure /run/mysqld exists with correct permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy database initialization script
COPY ./tools/init-db.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

# Expose MySQL port
EXPOSE 3306

# Start MariaDB
ENTRYPOINT ["/docker-entrypoint-initdb.d/init-db.sh"]
CMD ["mysqld"]