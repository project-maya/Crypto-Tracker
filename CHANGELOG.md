# 📦 Changelog

All notable changes to this project will be documented in this file.  
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [v1.1.1] - 2025-08-21
### Added
- 📦 `Credits` component in Dioxus UI to display project dependencies and acknowledgments.
- 🏷️ `PhaseBanner` component showing current roadmap milestone (`v1.1.1 – UI Baseline`).
- 🖥️ Static UI scaffold using Dioxus 0.6.3 with hot-reload via `dx serve`.
- 🧭 README updates linking roadmap badge and milestone to credits section.
- 📂 `credits.json` stub added for future dynamic loading of dependencies.

### Changed
- 🔧 Reverted dynamic `Credits` component to static list for stability and reproducibility.
- 🧹 Cleaned up RSX syntax and removed borrow checker errors in UI rendering.
- 🛠️ Updated workspace structure to isolate `ui/` crate and remove broken `backend/` reference.

### Notes
- This release marks the first reproducible UI baseline for the Shariah-compliant crypto tracker.
- Dynamic credits loading and version-aware banners are planned for future enhancement.

---

## [v1.1.0] - 2025-08-14
### Added
- 🗄️ D1 schema and seed for users, portfolios, assets, and compliance tags (`HALAL`, `REVIEW`, `EXCLUDE`).
- 🔍 `/health` endpoint for backend status checks.
- 📈 Edge-scheduled price snapshots from Binance REST API.
- 🧪 Reproducible migration-based DB setup using Cloudflare Workers.

### Notes
- This release established the backend foundation for compliance-aware crypto tracking.
- UI was served via static HTML; Dioxus integration begins in v1.1.1.

---

## [Unreleased]
### Planned
- 🛠️ REST API for portfolio and holdings CRUD.
- ⚡ Live market prices with KV caching.
- ✅ Compliance enforcement in API layer.
- 🌐 Dioxus UI served from Worker (v1.3.0).
