#!/usr/bin/env bash
set -euo pipefail

RECIPE="${1:-}"
shift || true

if [[ -z "${RECIPE}" ]]; then
  echo "Uso: $0 recipes/basic.txt up -d"
  exit 1
fi

# Por ahora SOLO soportamos core (más adelante agregamos módulos)
docker compose --env-file .env -f compose/core.yaml "$@"
