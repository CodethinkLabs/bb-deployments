#!/usr/bin/env bash

set -eux

CERTS=config-storage-clients
SUBJ="/C=US/ST=Ohio/L=Columbus/O=Acme Company/OU=Acme/CN=ironpad"

openssl genrsa -out $CERTS/server.key 2048
openssl req -new  -x509 -sha256 -key $CERTS/server.key -out $CERTS/server.crt -days 3650 -subj "$SUBJ"

#openssl req -new -sha256 -key $CERTS/server.key -out $CERTS/server.csr -subj "$SUBJ"
#openssl x509 -req -sha256 -in $CERTS/server.csr -signkey $CERTS/server.key -out $CERTS/server.crt -days 3650

for worker in worker-debian8 worker-ubuntu16-04; do
  sudo rm -rf "${worker}"
  mkdir -m 0777 "${worker}" "${worker}/build"
  mkdir -m 0700 "${worker}/cache"
done

exec docker-compose up
