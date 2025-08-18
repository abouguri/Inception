FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    nginx \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /var/www/html/adminer.php https://www.adminer.org/latest.php

RUN echo '<?php header("Location: adminer.php"); exit(); ?>' > /var/www/html/index.php

RUN chown -R www-data:www-data /var/www/html \
    && chmod 755 /var/www/html/adminer.php

COPY ./conf/nginx.conf /etc/nginx/sites-available/default

RUN mkdir -p /run/php

EXPOSE 8080

COPY ./conf/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
