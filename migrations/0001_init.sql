-- migrations/0001_init.sql
PRAGMA foreign_keys = ON;

-- Core catalog of trackable assets
CREATE TABLE IF NOT EXISTS assets (
  symbol TEXT PRIMARY KEY,              -- e.g., BTC, ETH
  name TEXT NOT NULL,                   -- e.g., Bitcoin
  chain TEXT NOT NULL,                  -- e.g., BTC, Ethereum, Solana
  decimals INTEGER NOT NULL DEFAULT 8,  -- UI hint; not on-chain source of truth
  compliance_status TEXT NOT NULL CHECK (compliance_status IN ('HALAL','REVIEW','EXCLUDE')),
  compliance_reason TEXT,               -- short note justifying current status
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_assets_chain ON assets(chain);

-- Minimal user and portfolio model for testing valuations
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS portfolios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Holdings recorded in base units (not price-converted)
CREATE TABLE IF NOT EXISTS portfolio_holdings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  portfolio_id INTEGER NOT NULL,
  asset_symbol TEXT NOT NULL,
  amount TEXT NOT NULL, -- stored as string to avoid float drift; parse to decimal in app
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),
  UNIQUE (portfolio_id, asset_symbol),
  FOREIGN KEY (portfolio_id) REFERENCES portfolios(id) ON DELETE CASCADE,
  FOREIGN KEY (asset_symbol) REFERENCES assets(symbol) ON DELETE RESTRICT
);