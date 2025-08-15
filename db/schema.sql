CREATE TABLE IF NOT EXISTS assets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    symbol TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    halal_status TEXT CHECK(halal_status IN ('halal','review','exclude')) DEFAULT 'review'
);

CREATE TABLE IF NOT EXISTS prices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    symbol TEXT NOT NULL,
    price_usd REAL NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);