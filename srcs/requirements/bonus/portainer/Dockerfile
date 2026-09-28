FROM debian:bookworm

RUN apt-get update && apt-get install -y wget tar ca-certificates && apt-get clean

RUN wget https://github.com/portainer/portainer/releases/download/2.45.1/portainer-2.45.1-linux-amd64.tar.gz -O /tmp/portainer.tar.gz \
    && tar -xzvf /tmp/portainer.tar.gz -C /opt/ \
    && rm /tmp/portainer.tar.gz

EXPOSE 9000

CMD ["/opt/portainer/portainer"]