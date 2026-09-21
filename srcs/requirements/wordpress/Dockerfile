FROM debian:bookworm

RUN apt-get update && apt-get install -y wget php php-fpm php-mysql mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress
RUN mkdir -p /run/php

RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

COPY ./conf/config.sh /
RUN chmod +x /config.sh

WORKDIR /var/www/wordpress

CMD ["/config.sh"]