LEGO-N8N 🧱🤖 (Plantilla tipo LEGO para n8n + Docker)

IDEA:
- CORE (base): n8n + Postgres (siempre)
- MÓDULOS (piezas opcionales): proxy, ollama, qdrant, redis, etc.
- RECETAS: combinaciones listas para levantar (basic, assistant, ai-rag...)

ESTRUCTURA:
compose/
  core.yaml                 Core: n8n + postgres + red + volúmenes
  modules/                  Piezas opcionales (proxy, ollama...)

env/
  core.env.example          Ejemplo de variables (sin secretos reales)
  modules/                  Ejemplos de variables por módulo (opcional)

recipes/
  basic.txt                 Receta: core
  assistant.txt             Receta: core + módulos (cuando existan)

scripts/
  stack.sh                  “Control remoto” para levantar recetas

modules/
  proxy-caddy/              Archivos extra de un módulo (Caddyfile, etc.)

n8n/
  workflows/                Export/backup de flujos (JSON)

data/                       Persistencia local (NO se sube a GitHub)
  n8n/                      Config y estado de n8n
  postgres/                 Data directory de Postgres

REQUISITOS (Ubuntu/Debian):
- git
- docker
- docker compose plugin

INSTALAR DOCKER:
sudo apt update
sudo apt install -y docker.io docker-compose-plugin
sudo systemctl enable --now docker

PERMISOS DOCKER (para no usar sudo):
sudo usermod -aG docker $USER
newgrp docker
docker ps

CONFIGURAR VARIABLES (NO subir a GitHub):
cp env/core.env.example .env
nano .env
- Cambia POSTGRES_PASSWORD
- Cambia N8N_ENCRYPTION_KEY (32+ chars)

LEVANTAR CORE:
./scripts/stack.sh up basic
./scripts/stack.sh ps basic

ABRIR n8n:
http://localhost:5678
(o desde LAN: http://IP_DEL_SERVIDOR:5678)

TROUBLESHOOTING:
Revisa docs/troubleshooting/ para errores comunes:
- Docker permission denied
- Variables not set (.env no leído)
- n8n EACCES en /home/node/.n8n
- Postgres permisos UID/GID + ACL
- Warning de Python missing
