FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx vim curl openssl
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=NOR/L=LeHavre/O=42/OU=42/CN=efoyer.42.fr/UID=efoyer"
RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]