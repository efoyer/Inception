FROM debian:bookworm

RUN apt-get update && apt-get install -y redis

RUN sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf
RUN sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf
RUN sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

COPY ./tools/run.sh /tmp/run-redis.sh
EXPOSE 6379

CMD ["sh", "/tmp/run-redis.sh"]