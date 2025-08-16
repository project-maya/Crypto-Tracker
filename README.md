---
# Crypto Tracker Backend

[![GitHub release](https://img.shields.io/github/v/release/project-maya/Crypto-Tracker?sort=semver&color=success&label=release)](https://github.com/project-maya/Crypto-Tracker/releases)

Rust + Cloudflare Workers backend for a Shariah‑compliant, privacy‑focused crypto tracker.

---

# Crypto-Tracker (Rust + Cloudflare Edge)

A lean, Rust-first crypto market watch and portfolio tracker hosted at the edge. It tracks a curated set of assets and supports Shariah-compliance tagging out of the box.

---

## Repository Structure

crypto-tracker/
├─ wrangler.toml             # Cloudflare config and bindings
├─ package.json              # scripts for dev/deploy and TypeScript build
├─ README.md
├─ .github/
│  └─ workflows/deploy.yml   # optional CI deploy with Wrangler
├─ src/
│  └─ lib.rs                 # Rust Worker entry (routes + scheduler)
│  └─ routes.rs              # API handlers (prices, portfolio stub)
├─ db/
│  ├─ schema.sql             # D1 schema
│  └─ seed.sql               # initial assets + halal tags
└─ public/
   └─ index.html

---

## Features

- Live market watch via edge-scheduled price snapshots (Binance REST)
- Portfolio + holdings in Cloudflare D1 (SQLite at the edge)
- Shariah-compliance tags with instant filter capability
- Static UI served from the Worker (polling every 5s)
- Optional Durable Object for WebSocket fan-out (Phase 2)

---

## Stack

- Rust Workers (compiled to WASM via workers-rs)
- Cloudflare: Workers, KV (price cache), D1 (state), Assets (static), optional Durable Objects
- Minimal HTML UI; upgrade to Svelte/React later
- GitHub Actions (optional) for CI deploy

---

## Getting started

1. Prereqs: Rust (wasm32 target), Node, Wrangler
2. Install deps:
   - `npm i -g wrangler`
   - `rustup target add wasm32-unknown-unknown`
3. Cloudflare resources:
   - `wrangler kv namespace create PRICES_KV`
   - `wrangler d1 create halal_watch`
4. Configure `wrangler.toml` with your KV/D1 IDs.
5. Secrets:
   - `wrangler secret put BINANCE_API_BASE` (e.g., `https://api.binance.com`)
6. Seed DB:
   - `wrangler d1 execute halal_watch --file db/schema.sql`
   - `wrangler d1 execute halal_watch --file db/seed.sql`
7. Run locally: `wrangler dev`
8. Deploy: `wrangler deploy`

Set a cron in Cloudflare (or via `wrangler deploy --triggers.cron="* * * * *"`) so prices refresh every minute.

---

## API

- `GET /api/prices?symbols=BTC,ETH,ADA` → latest prices from KV
- `GET /api/portfolio/:id` → holdings + compliance tags (seed has `:id = 1`)

---

## Roadmap

- WebSocket live updates via Durable Object
- On-chain balance resolvers (EVM, Cardano, Solana)
- Alerts (email/webhook) via Cloudflare Queues
- CSV import/export and cost basis analytics

---

## Notes

- Only spot price snapshots are stored; no derivatives.
- Compliance tags are simple and auditable; update `db/seed.sql` or write an admin route.
