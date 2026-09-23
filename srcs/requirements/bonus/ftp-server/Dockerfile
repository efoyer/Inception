FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd
RUN mkdir -p /var/run/vsftpd/empty

COPY conf/ftp.conf /etc/vsftpd/vsftpd.conf
COPY tools/run-ftp.sh /tmp/run-ftp.sh

ENTRYPOINT [ "sh", "/tmp/run-ftp.sh" ]