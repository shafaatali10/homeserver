#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_DIR=$(cd -- "$SCRIPT_DIR/.." && pwd)
COMPOSE_DIR=/srv/docker/compose/tiddlywiki

mkdir -p "$COMPOSE_DIR" /srv/docker/data/tiddlywiki

if ! docker ps --format '{{.Names}}' | grep -q '^tiddlywiki$'; then
    cp "$REPO_DIR/docker/tiddlywiki/docker-compose.yml" "$COMPOSE_DIR/"
    echo "Starting TiddlyWiki..."
    docker compose -f "$COMPOSE_DIR/docker-compose.yml" up -d
else
    echo "TiddlyWiki is already running."
fi
