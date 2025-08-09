FROM debian:bullseye

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install MariaDB server and client
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create mysql directories and set permissions
RUN mkdir -p /var/run/mysqld /var/lib/mysql /var/log/mysql \
    && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /var/log/mysql \
    && chmod 755 /var/run/mysqld

# Copy custom MariaDB configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copy initialization script
COPY ./tools/init-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-db.sh

# Expose MariaDB port
EXPOSE 3306

# Switch to mysql user
USER mysql

# Start MariaDB with custom script
CMD ["/usr/local/bin/init-db.sh"]