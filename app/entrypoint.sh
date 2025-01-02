#!/usr/bin/env bash

set -e
set -u
set -o pipefail
set -C

CERTBOT_CMD=/usr/bin/certbot
SLEEP_INTERVAL=86400
trap "echo trapped.; kill -15 -$$" EXIT

echo "make cli.ini"
cat <<EOL | tee /etc/letsencrypt/cli.ini
# Because we are using logrotate for greater flexibility, disable the
# internal certbot logrotation.
max-log-backups = 0
# Adjust interactive output regarding automated renewal
preconfigured-renewal = True
# Use ECC for the private key
key-type = ecdsa
elliptic-curve = secp384r1
# Use a 4096 bit RSA key instead of 2048
rsa-key-size = 4096
EOL

echo
echo "certbot renew check start..."
while true; do
    sleep $SLEEP_INTERVAL
    $CERTBOT_CMD renew --no-random-sleep-on-renew
done
