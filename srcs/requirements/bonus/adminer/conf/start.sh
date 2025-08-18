#!/bin/bash

# Start PHP-FPM
php-fpm7.4 -D

# Start Nginx in foreground
nginx -g "daemon off;"
