FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
ENV LS_COLORS="di=01;36"
WORKDIR /app
COPY ./app/entrypoint.sh /app/entrypoint.sh
RUN --mount=type=cache,target=/var/lib/apt/lists --mount=type=cache,target=/var/cache/apt/archives \
 apt update \
 && apt install -y --no-install-recommends curl git cron ca-certificates socat openssl  \
 && apt install -y certbot python3-certbot-dns-route53 \
 && mkdir /var/log/letsencrypt \
 && (cd /var/log/letsencrypt; ln -s /proc/self/fd/1 letsencrypt.log) \
 && chmod 755 /app/entrypoint.sh

CMD [ "/app/entrypoint.sh" ]
