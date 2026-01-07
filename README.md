# LEGO-N8N 🧱🤖
Plantilla tipo **LEGO** para proyectos con **n8n + Docker Compose**.

La idea:
- **Core (base)**: n8n + Postgres (siempre)
- **Módulos (piezas opcionales)**: proxy, ollama, qdrant, redis, etc.
- **Recetas (builds)**: combinaciones listas (ej. `basic`, `assistant`, `ai-rag`)

> Este repo está pensado para que puedas armar distintos proyectos sin reescribir todo:
> “castillo”, “nave espacial”, “asistente con IA”… solo cambias receta/módulos.

---

## Estructura del repo

```txt
compose/
  core.yaml                 # Core: n8n + postgres + red + volúmenes
  modules/                  # Piezas opcionales (proxy, ollama, etc.)

env/
  core.env.example          # Ejemplo de variables (NO secretos reales)
  modules/                  # Ejemplos de variables por módulo (opcional)

recipes/
  basic.txt                 # Receta: core
  assistant.txt             # Receta: core + módulos (cuando existan)

scripts/
  stack.sh                  # “Control remoto” para levantar recetas

modules/
  proxy-caddy/              # Archivos extra de un módulo (ej. Caddyfile)

n8n/
  workflows/                # Export/backup de flujos (JSON)

data/                       # Persistencia local (NO se sube a GitHub)
  n8n/                      # Config y estado de n8n
  postgres/                 # Data directory de Postgres
