# Crypto-Tracker
A crypto tracker build with Rust-first for Cloudflare-edge

Repository layout
- Root
    - wrangler.toml — Cloudflare config and bindings
    - package.json — scripts for dev/deploy and TypeScript build
    - README.md — shipped below
    - .github/workflows/deploy.yml — optional CI deploy with Wrangler
- src/
    - lib.rs — Rust Worker entry (routes + scheduler)
    - routes.rs — API handlers (prices, portfolio stub)
- db/
    - schema.sql — D1 schema
    - seed.sql — initial assets + halal tags
- public/
    - index.html — minimal market watch UI (polling)
- do/ (optional Phase 2)
    - ticker_hub.ts — Durable Object for WebSocket fan‑out

Step‑by‑step setup
1. Prerequisites
    - Rust: stable toolchain and wasm target
    - rustup target add wasm32-unknown-unknown
    - Node + pnpm/npm: to drive Wrangler and DO TypeScript
    - Cloudflare Wrangler: npm i -g wrangler
    - Cloudflare account: account id and an API token with Worker/D1/KV permissions
2. Create the project folder
    - mkdir halal-watch && cd halal-watch
    - git init
3. Initialize Node workspace
    - pnpm init -y
    - pnpm add -D wrangler typescript esbuild
4. Create a new Rust library for the Worker
    - cargo new --lib edge --vcs none
    - Move its contents up into src/ (we’ll keep code under src/)
        - rm -rf edge
    - Ensure Rust compiles to WASM:
        - echo ‘[lib]\ncrate-type = ["cdylib"]’ >> Cargo.toml
5. Add Cloudflare resources
    - KV namespace for prices:
        - wrangler kv namespace create PRICES_KV
    - D1 database:
        - wrangler d1 create halal_watch
    - Note the IDs; you’ll paste them into wrangler.toml.
6. Set Cloudflare secrets
    - wrangler secret put BINANCE_API_BASE
        - Use https://api.binance.com (or a mirror if rate‑limited)
7. Create GitHub repo and push
    - On GitHub, create an empty repo (e.g., halal-watch)
    - Locally:
        - git remote add origin https://github.com/yourname/halal-watch.git
        - echo "node_modules\nbuild\n.wrangler\n" >> .gitignore
        - git add .
        - git commit -m "feat: initial edge MVP"
        - git push -u origin main
8. Local dev and first deploy
    - pnpm wrangler dev
    - In another terminal, seed D1:
        - wrangler d1 execute halal_watch --file db/schema.sql
        - wrangler d1 execute halal_watch --file db/seed.sql
    - Deploy:
        - pnpm wrangler deploy

# Halal Watch (Rust + Cloudflare Edge)

A lean, Rust-first crypto market watch and portfolio tracker hosted at the edge. It tracks a curated set of assets and supports Shariah-compliance tagging out of the box.

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
