#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
APPS_DIR="$SCRIPT_DIR/apps"

run_app() {
    local app=$1
    "$APPS_DIR/$app.sh"
}

if (($# == 0)); then
    set -- all
fi

case $1 in
    all)
        run_app vaultwarden
        run_app pihole
        run_app gitea
        run_app nextcloud
        run_app tiddlywiki
        ;;
    vaultwarden|pihole|gitea|nextcloud|tiddlywiki)
        run_app "$1"
        ;;
    *)
        printf 'Usage: %s [all|vaultwarden|pihole|gitea|nextcloud|tiddlywiki]\n' "$0" >&2
        exit 1
        ;;
esac