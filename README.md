
---

# 🕌 Shariah‑Compliant Crypto Tracker  
**Rust + Cloudflare Workers + Dioxus Roadmap | Ethical | Serverless | Reproducible**

A lean, Rust‑first crypto market watch and portfolio tracker hosted at the edge.  
Built to deliver **fast, privacy‑first tracking** of a curated set of crypto assets —  
with **Shariah‑compliance tagging and filtering baked in** from the start.

[![GitHub release](https://img.shields.io/github/v/release/project-maya/Crypto-Tracker?sort=semver&color=success&label=release)](https://github.com/project-maya/Crypto-Tracker/releases)  
[![Roadmap Progress](https://img.shields.io/badge/Roadmap-v1.1.1%20UI%20Baseline-blue)](#-credits)  
[![Live Dev UI](https://img.shields.io/badge/dev%20UI-online-brightgreen)](http://127.0.0.1:8080) <!-- Local/dev link for reference -->

---

## 📖 Mission

Crypto investment tools are everywhere — but few prioritize **ethical transparency**  
and **faith‑aligned compliance**. This tracker exists to fill that gap by:

- Tracking only approved or review‑status assets based on compliance rules you control.  
- Running **entirely on serverless edge infrastructure** for speed and scalability.  
- Keeping **data flows minimal** for privacy, without selling or sharing usage data.  
- Providing a **reproducible, version‑controlled backend + UI** so anyone can self‑host with confidence.

---

## 🚀 Features

### ✅ Current (v1.1.0) – *Backend Foundations*
- **D1 schema & seed** for users, portfolios, assets, and compliance tags (`HALAL`, `REVIEW`, `EXCLUDE`)  
- `/health` endpoint for quick backend status checks  
- Edge‑scheduled price snapshots from Binance REST API  
- Reproducible migration‑based DB setup  

### 🟦 [v1.1.1 (UI Baseline)](#-credits)
- **Dioxus UI crate builds & serves locally** via `dx serve --platform web`  
- Hot‑reload in browser for rapid front‑end iteration  
- Baseline component ready for future API integration

### 🛠 In Progress (v1.2.0 – “API Foundations”)
- REST API for:  
  - Portfolio CRUD  
  - Holdings CRUD  
  - Live market prices with KV caching  
- Compliance enforcement in API layer

### 🔮 Upcoming

| Version   | Codename                 | Highlights |
|-----------|--------------------------|------------|
| v1.3.0    | **Rust‑UI Web**           | Dioxus WASM front‑end served from Worker; replace static HTML UI |
| v2.0.0    | **Live Edge**             | Durable Objects for WebSocket streaming, near‑real‑time prices |
| v2.1.0    | **On‑Chain Insights**     | Address resolvers for EVM, Cardano, Solana |
| v2.2.0    | **Alerts & Automation**   | Price/compliance alerts via Cloudflare Queues (email/webhook) |
| v3.0.0    | **Everywhere**            | Dioxus packaged for Desktop (Tauri) + Mobile (iOS/Android) |
| v3.1.0    | **Advanced Analytics**    | CSV import/export, cost basis, P/L analysis |

---

## 🛠 Stack

- **Rust Workers** → [`workers-rs`](https://github.com/cloudflare/workers-rs), compiled to WASM  
- **Cloudflare** → Workers, KV, D1, Assets, Durable Objects (future)  
- **Dioxus** (from v1.3.0) → Cross‑platform UI in Rust (Web, Desktop, Mobile)  
- Minimal HTML UI → Phase‑out in favour of Dioxus front‑end  
- GitHub Actions → CI/CD

---

## 📂 Repository Structure

```text
crypto-tracker/
├─ wrangler.toml
├─ package.json
├─ src/
│  ├─ lib.rs
│  └─ routes.rs
├─ migrations/
│  ├─ 0001_init.sql
│  └─ 0002_seed.sql
├─ public/
│  ├─ index.html
│  └─ app/            # Built Dioxus web artifacts
├─ ui/                # Dioxus app (Rust UI)
│  ├─ src/
│  │  └─ main.rs
│  ├─ Cargo.toml
│  └─ dist/           # dx build output
├─ .github/workflows/
└─ README.md
```

---

## ⚡ Quickstart

```bash

# Install prerequisites
npm i -g wrangler
rustup target add wasm32-unknown-unknown

# Create Cloudflare KV & D1
wrangler kv namespace create PRICES_KV
wrangler d1 create crypto_tracker

# Apply schema & seed
wrangler d1 execute crypto_tracker --file=./db/schema.sql
wrangler d1 execute crypto_tracker --file=./db/seed.sql

# Run backend locally
wrangler dev

# Run UI locally
cd ui
dx serve --platform web

# Deploy backend
wrangler deploy

```

Schedule a Cloudflare Cron (`*/1 * * * *`) to refresh prices every minute.

---

## 📡 API Reference
- `GET /health` → DB status & asset count  
- (More endpoints in v1.2.0+)

---

## 📜 Notes
- Only spot prices stored; no derivatives  
- Compliance rules are transparent and auditable

---

## 🤝 Contributing
PRs and feature ideas are welcome! Open an issue to start the conversation. If your change adds a new dependency, please also update `credits.json`.

---

## 🔍 Credits

This project stands on the shoulders of some excellent open‑source work and services.

📦 Credits are dynamically loaded from [`credits.json`](./ui/public/credits.json) for transparency and reproducibility.

Example entries:

* 🦀 [Rust](https://www.rust-lang.org)
* 🎨 [Dioxus](https://dioxuslabs.com)
* ⚡ [workers‑rs](https://github.com/cloudflare/workers-rs)

…plus more in the full list.

---

## 📄 License
MIT — see LICENSE

---