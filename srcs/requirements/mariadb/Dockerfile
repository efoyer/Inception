FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server
COPY conf/mariadb.conf /et/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/script.sh /
RUN chmod +x /script.sh
CMD ["/script.sh"]