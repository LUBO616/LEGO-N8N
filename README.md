# LEGO-N8N 🧱🤖  
## Modular n8n Stack (Core + Modules) — ES / EN

Build a clean, repeatable **n8n** deployment with Docker: a stable **CORE** (n8n + DB + reverse proxy) and optional **modules** (local AI, vector DB, storage, queues, etc.) you can plug in later like LEGO.

---

## ✨ What’s inside (today)

### ✅ CORE (stable)
- **n8n** — workflow automation platform
- **Postgres** — persistent database (recommended over SQLite)
- **Caddy** — reverse proxy (LAN/lab via HTTP for now)

### 🧩 Optional Modules (plug later)
- **Ollama** — local AI (defined as a module; will be enabled next)
- Future: Qdrant, MinIO, Redis, Tika, Queue Mode/workers…

---

## 🚀 Quick Start (CORE)

> You’ll access n8n via **Caddy** on port **80**: `http://localhost` or `http://SERVER_IP`

### 1) Clone
```bash
git clone git@github.com:LUBO616/LEGO-N8N.git
cd LEGO-N8N
```

### 2) Create your `.env` (DO NOT COMMIT)
```bash
cp env/core.env.example .env
nano .env
```

**Important variables:**
- `PUBLIC_URL`  
  - local: `http://localhost`  
  - LAN: `http://SERVER_IP`
- `N8N_ENCRYPTION_KEY` (>= 32 chars, strong)
- `POSTGRES_PASSWORD` (strong)
- If you access via IP over HTTP (LAN/lab):  
  - `N8N_SECURE_COOKIE=false`

Generate a strong key:
```bash
openssl rand -hex 32
```

### 3) Start CORE
```bash
./scripts/stack.sh recipes/basic.txt up -d
```

### 4) Open n8n
- Local: `http://localhost`
- LAN: `http://SERVER_IP`

### 5) Status & logs
```bash
./scripts/stack.sh recipes/basic.txt ps
./scripts/stack.sh recipes/basic.txt logs -n 120 n8n
./scripts/stack.sh recipes/basic.txt logs -n 120 caddy
./scripts/stack.sh recipes/basic.txt logs -n 120 postgres
```

### 6) Stop
```bash
./scripts/stack.sh recipes/basic.txt down
```

---

## 🧠 How it works (one-minute mental model)

- **Caddy** listens on **port 80** and forwards requests to **n8n** (reverse proxy).  
- **n8n** stores workflows, users and executions in **Postgres** (persistence).  
- **data/** keeps local state (DB + n8n config) and must never be pushed to GitHub.

**Flow:**  
`Browser → Caddy :80 → n8n :5678 → Postgres :5432`

---

## 🗂 Repo Structure

```text
LEGO-N8N/
├─ compose/
│  ├─ core.yaml                # CORE: n8n + postgres + caddy
│  └─ modules/                 # optional modules (e.g., ollama.yaml)
├─ env/
│  ├─ core.env.example         # core env template
│  └─ modules/                 # module env templates (*.env.example)
├─ modules/
│  └─ proxy-caddy/             # Caddy assets (Caddyfile)
├─ scripts/
│  └─ stack.sh                 # start/stop wrapper (compose)
├─ recipes/
│  └─ basic.txt                # recipe: core only
├─ docs/
│  ├─ 01-core-paso-a-paso.txt
│  └─ 02-core-como-funciona-manual-para-pendejos.txt
└─ data/                       # local persistence (DO NOT COMMIT)
```

---

## 🔐 Security / Seguridad

### ✅ Do / Haz
- Keep **`.env`** private (secrets).
- Keep **`data/`** out of Git (real data).
- Use a strong **`N8N_ENCRYPTION_KEY`**.

### ❌ Don’t / No hagas
- Don’t commit `.env` or anything in `data/`.
- Don’t expose an HTTP-only setup to the public internet.

> Production note: migrate Caddy to **HTTPS** when going beyond LAN/lab.

---

## 🇲🇽 Español

### ¿Qué es LEGO-N8N?
**LEGO-N8N** es un repositorio modular para desplegar **n8n** con Docker de forma limpia y repetible:  
un **CORE estable** (n8n + DB + proxy) y **módulos opcionales** que se conectan después como LEGO.

### CORE (hasta ahora)
- **n8n** (automatización)
- **Postgres** (persistencia real)
- **Caddy** (proxy reverso HTTP para entrar por `http://IP`)

> Si entras por IP en HTTP y te aparece el aviso de cookies seguras, usa `N8N_SECURE_COOKIE=false` en tu `.env`.

---

## 🇺🇸 English

### What is LEGO-N8N?
**LEGO-N8N** is a modular repo to deploy **n8n** with Docker in a clean and repeatable way:  
a stable **CORE** (n8n + DB + proxy) plus **optional modules** you plug in later like LEGO.

### CORE (today)
- **n8n** (automation)
- **Postgres** (real persistence)
- **Caddy** (HTTP reverse proxy to access via `http://IP`)

> If you access via IP over HTTP and see secure-cookie warnings, set `N8N_SECURE_COOKIE=false` in your `.env`.

---

## 🛣 Roadmap
- [ ] Enable **Ollama** module + recipe (core + ollama)
- [ ] Add HTTPS with Caddy (production-ready)
- [ ] Workflow import/export helpers
- [ ] Security hardening baseline

---
