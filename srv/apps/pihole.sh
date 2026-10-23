#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_DIR=$(cd -- "$SCRIPT_DIR/.." && pwd)
COMPOSE_DIR=/srv/docker/compose/pihole

mkdir -p "$COMPOSE_DIR" /srv/docker/data/pihole/etc-pihole /srv/docker/data/pihole/etc-dnsmasq.d

if ! docker ps --format '{{.Names}}' | grep -q '^pihole$'; then
    sudo cp "$REPO_DIR/docker/pihole/resolved.conf" /etc/systemd/resolved.conf
    sudo rm /etc/resolv.conf
    echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf >/dev/null
    sudo systemctl restart systemd-resolved

    cp "$REPO_DIR/docker/pihole/docker-compose.yml" "$COMPOSE_DIR/"
    echo "Starting Pi-hole..."
    docker compose -f "$COMPOSE_DIR/docker-compose.yml" up -d
else
    echo "Pi-hole is already running."
fi
