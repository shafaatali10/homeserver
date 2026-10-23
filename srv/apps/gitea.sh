#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_DIR=$(cd -- "$SCRIPT_DIR/.." && pwd)
COMPOSE_DIR=/srv/docker/compose/gitea

mkdir -p "$COMPOSE_DIR"

if ! docker ps --format '{{.Names}}' | grep -q '^gitea$'; then
    cp "$REPO_DIR/docker/gitea/docker-compose.yml" "$COMPOSE_DIR/"
    echo "Starting Gitea..."
    docker compose -f "$COMPOSE_DIR/docker-compose.yml" up -d
else
    echo "Gitea is already running."
fi
