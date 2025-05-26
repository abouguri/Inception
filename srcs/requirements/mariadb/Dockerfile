FROM debian:buster

# Install MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/init_db.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/init_db.sh

# Expose port 3306
EXPOSE 3306

# Start MariaDB
ENTRYPOINT ["init_db.sh"]