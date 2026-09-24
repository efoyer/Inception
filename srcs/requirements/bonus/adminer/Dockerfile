FROM debian:bookworm

RUN apt-get update && apt-get -y install wget ca-certificates php php-fpm php-mysql \
    && mkdir -p /var/www/html \
    && rm -f /var/www/html/index.html \
    && wget https://github.com/vrana/adminer/releases/download/v6.1.0/adminer-6.1.0.php -O /var/www/html/index.php \
    && chown www-data:www-data /var/www/html/index.php \
    && chmod 755 /var/www/html/index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]