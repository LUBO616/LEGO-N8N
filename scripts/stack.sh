#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-}"
RECIPE="${2:-}"

if [[ -z "$ACTION" || -z "$RECIPE" ]]; then
  echo "Uso: $0 {up|down|ps|logs|config} <recipe>"
  echo "Ejemplo: $0 up basic"
  exit 1
fi

RECIPE_FILE="recipes/${RECIPE}.txt"
if [[ ! -f "$RECIPE_FILE" ]]; then
  echo "No existe la receta: $RECIPE_FILE"
  exit 1
fi

FILES=()
while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  FILES+=("-f" "$f")
done < "$RECIPE_FILE"

BASE=(docker compose --project-directory . --env-file .env)

case "$ACTION" in
  up)     "${BASE[@]}" "${FILES[@]}" up -d ;;
  down)   "${BASE[@]}" "${FILES[@]}" down ;;
  ps)     "${BASE[@]}" "${FILES[@]}" ps ;;
  logs)   "${BASE[@]}" "${FILES[@]}" logs -f ;;
  config) "${BASE[@]}" "${FILES[@]}" config ;;
  *)
    echo "Acción inválida: $ACTION"
    exit 1
    ;;
esac
