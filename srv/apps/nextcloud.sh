#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_DIR=$(cd -- "$SCRIPT_DIR/.." && pwd)
COMPOSE_DIR=/srv/docker/compose/nextcloud

mkdir -p "$COMPOSE_DIR"

if ! docker ps --format '{{.Names}}' | grep -q '^nextcloud$'; then
    cp "$REPO_DIR/docker/nextcloud/docker-compose.yml" "$COMPOSE_DIR/"
    echo "Starting Nextcloud..."
    docker compose -f "$COMPOSE_DIR/docker-compose.yml" up -d
else
    echo "Nextcloud is already running."
fi
