#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../"


docker-compose up -d
NetworkID=$(docker inspect "$(docker-compose ps -q "vaultwarden")" | jq '.[0].NetworkSettings.Networks|map(select(true))[0].NetworkID' -r)
docker run \
    -e TARGETS="vaultwarden:80" \
    -e TIMEOUT=30 \
    --network "$NetworkID" \
    --rm \
    waisbrot/wait
bw config server http://localhost:8000

cat << EOF


Bitwarden is automatically setup, default login are:

email: admin@example.com
password: master_password
EOF