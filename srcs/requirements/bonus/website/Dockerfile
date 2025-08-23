FROM debian:bullseye

RUN apt-get update -o Acquire::CompressionTypes::Order::=gz && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY ./content/ /var/www/html/

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN rm -f /etc/nginx/sites-enabled/default

RUN chown -R www-data:www-data /var/www/html

EXPOSE 8888

CMD ["nginx", "-g", "daemon off;"]
