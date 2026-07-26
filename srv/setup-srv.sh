#!/usr/bin/env bash

set -euo pipefail

# For Docker Compose
mkdir -p /srv/docker/compose/

# For Docker Data
mkdir -p /srv/docker/data/

# For Docker Shared Data
mkdir -p /srv/docker/shared/


# For Media files
mkdir -p /srv/media/

chown -R $(whoami):$(whoami) /srv/docker/ /srv/media/