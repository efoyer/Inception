FROM debian:bookworm

RUN apt-get update && apt-get -y install wget
RUN wget https://github.com/vrana/adminer/releases/download/v6.1.0/adminer-6.1.0.php -O /var/www/html/adminer.php
RUN chown www-data:www-data /var/www/html/adminer.php && chmod 755 /var/www/html/adminer.php