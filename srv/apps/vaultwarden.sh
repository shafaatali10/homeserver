#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_DIR=$(cd -- "$SCRIPT_DIR/.." && pwd)
COMPOSE_DIR=/srv/docker/compose/vaultwarden

mkdir -p "$COMPOSE_DIR" /srv/docker/data/vaultwarden/db

if ! docker ps --format '{{.Names}}' | grep -q '^vaultwarden$'; then
    cp "$REPO_DIR/docker/vaultwarden/docker-compose.yml" "$COMPOSE_DIR/"
    echo "Starting Vaultwarden..."
    docker compose -f "$COMPOSE_DIR/docker-compose.yml" up -d
else
    echo "Vaultwarden is already running."
fi
