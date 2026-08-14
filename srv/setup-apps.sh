#!/usr/bin/env bash

set -euo pipefail

# For Vaultwarden
mkdir -p /srv/docker/compose/vaultwarden
mkdir -p /srv/docker/data/vaultwarden
mkdir -p /srv/docker/data/vaultwarden/db

# Check if the vaultwarden container is already running
if ! docker ps --format '{{.Names}}' | grep -q '^vaultwarden$'; then
    cp ./docker/vaultwarden/docker-compose.yml /srv/docker/compose/vaultwarden
    cd /srv/docker/compose/vaultwarden

    echo "Starting Vaultwarden..."
    docker-compose up -d
else
    echo "Vaultwarden is already running."
fi


# For Pi-hole
sudo mkdir -p /srv/docker/compose/pihole
sudo mkdir -p /srv/docker/data/pihole/etc-pihole
sudo mkdir -p /srv/docker/data/pihole/etc-dnsmasq.d

# Check if the pihole container is already running
if ! docker ps --format '{{.Names}}' | grep -q '^pihole$'; then

    mv /etc/systemd/resolved.conf /etc/systemd/resolved.conf.bak
    cp ./docker/pihole/resolved.conf /etc/systemd/resolved.conf

    sudo rm /etc/resolv.conf
    echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf

    systemctl restart systemd-resolved


    cp ./docker/pihole/docker-compose.yml /srv/docker/compose/pihole
    cd /srv/docker/compose/pihole

    echo "Starting Pi-hole..."
    docker-compose up -d
else
    echo "Pi-hole is already running."
fi