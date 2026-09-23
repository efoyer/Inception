FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx unzip
RUN rm -rf /var/www/html/*
COPY ./website /var/www/html/
RUN unzip -j /var/www/html/images.zip -d /var/www/html/ && rm /var/www/html/images.zip

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]