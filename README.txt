LEGO-N8N 🧱🤖 (Plantilla tipo LEGO para n8n + Docker)

IDEA:
- CORE (base): n8n + Postgres (siempre)
- MÓDULOS (piezas opcionales): proxy, ollama, qdrant, redis, etc.
- RECETAS: combinaciones listas (basic, assistant, assistant-ollama...)

ESTRUCTURA:
compose/
  core.yaml                 Core: n8n + postgres + red + volúmenes (SIN exponer puertos por defecto)
  modules/
    expose-n8n.yaml         Módulo: expone n8n en :5678 (cuando NO usas proxy)
    proxy-caddy.yaml        Módulo: proxy HTTP :80 -> n8n

env/
  core.env.example          Ejemplo de variables (sin secretos reales)
  modules/                  Ejemplos de variables por módulo

recipes/
  basic.txt                 Receta: core + expose-n8n (entrar por http://IP:5678)
  assistant.txt             Receta: core + proxy-caddy (entrar por http://IP/)

scripts/
  stack.sh                  “Control remoto” para levantar recetas

modules/
  proxy-caddy/              Config del proxy (Caddyfile)

n8n/
  workflows/                Export/backup de flujos (JSON)

data/                       Persistencia local (NO se sube a GitHub)
  n8n/                      Config/credenciales
  postgres/                 Data directory

REQUISITOS (Ubuntu/Debian):
sudo apt update
sudo apt install -y git docker.io docker-compose-plugin
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
- Si usas HTTP con proxy: N8N_SECURE_COOKIE=false

LEVANTAR (modo LEGO con recetas):
./scripts/stack.sh up basic
./scripts/stack.sh ps basic
Abrir: http://IP_DEL_SERVIDOR:5678

./scripts/stack.sh up assistant
./scripts/stack.sh ps assistant
Abrir: http://IP_DEL_SERVIDOR/

NOTAS IMPORTANTES:
- stack.sh usa: --project-directory . y --env-file .env
- stack.sh usa: --remove-orphans (para quitar módulos que ya no se usan al cambiar de receta)
- data/ y .env NO se suben a GitHub

TROUBLESHOOTING:
Revisa docs/troubleshooting/ para errores comunes:
- Docker permission denied
- .env no leído (Variables not set)
- n8n EACCES en /home/node/.n8n
- Postgres UID/GID + ACL
- Secure cookie (HTTP vs HTTPS)
