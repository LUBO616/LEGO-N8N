#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-up}"          # up|down|ps|logs|pull
RECIPE="${2:-basic}"       # basic|assistant-hr|full

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CORE_FILE="$ROOT_DIR/compose/core.yaml"
RECIPE_FILE="$ROOT_DIR/recipes/${RECIPE}.txt"

FILES=(-f "$CORE_FILE")
PROFILES=()

if [[ -f "$RECIPE_FILE" ]]; then
  while IFS= read -r line; do
    line="${line%%#*}"                       # quita comentarios
    line="$(echo -n "$line" | xargs || true)" # recorta espacios
    [[ -z "$line" ]] && continue

    MOD_FILE="$ROOT_DIR/compose/modules/${line}.yaml"
    if [[ ! -f "$MOD_FILE" ]]; then
      echo "❌ No existe módulo: $line ($MOD_FILE)"
      exit 1
    fi

    FILES+=(-f "$MOD_FILE")
    PROFILES+=(--profile "$line")
  done < "$RECIPE_FILE"
fi

cd "$ROOT_DIR"

case "$ACTION" in
  up)    docker compose "${FILES[@]}" "${PROFILES[@]}" up -d ;;
  down)  docker compose "${FILES[@]}" "${PROFILES[@]}" down ;;
  ps)    docker compose "${FILES[@]}" "${PROFILES[@]}" ps ;;
  logs)  docker compose "${FILES[@]}" "${PROFILES[@]}" logs -f --tail=200 ;;
  pull)  docker compose "${FILES[@]}" "${PROFILES[@]}" pull ;;
  *)     echo "Uso: $0 {up|down|ps|logs|pull} {basic|assistant-hr|full}"; exit 1 ;;
esac
