PRAGMA foreign_keys = ON;

-- 1. Seed user
INSERT OR IGNORE INTO users (email, display_name)
VALUES ('user@example.com', 'User');

-- 2. Seed portfolio
INSERT OR IGNORE INTO portfolios (user_id, name)
SELECT id, 'Demo'
FROM users
WHERE email = 'user@example.com';

-- 3. Seed assets
INSERT OR IGNORE INTO assets (symbol, name, chain, decimals, compliance_status, compliance_reason)
VALUES
  ('BTC','Bitcoin','Bitcoin',8,'HALAL','Decentralized PoW; placeholder for testing'),
  ('ETH','Ethereum','Ethereum',18,'REVIEW','Staking/MEV considerations; placeholder'),
  ('SOL','Solana','Solana',9,'REVIEW','Centralization debates; placeholder'),
  ('ADA','Cardano','Cardano',6,'REVIEW','Staking model; placeholder'),
  ('BNB','BNB Chain','BNB Chain',18,'EXCLUDE','Issuer/control risk; placeholder');

-- 4. Update existing assets individually
UPDATE assets SET
  name='Bitcoin',
  chain='Bitcoin',
  decimals=8,
  compliance_status='HALAL',
  compliance_reason='Decentralized PoW; placeholder for testing',
  updated_at=datetime('now')
WHERE symbol='BTC';

UPDATE assets SET
  name='Ethereum',
  chain='Ethereum',
  decimals=18,
  compliance_status='REVIEW',
  compliance_reason='Staking/MEV considerations; placeholder',
  updated_at=datetime('now')
WHERE symbol='ETH';

UPDATE assets SET
  name='Solana',
  chain='Solana',
  decimals=9,
  compliance_status='REVIEW',
  compliance_reason='Centralization debates; placeholder',
  updated_at=datetime('now')
WHERE symbol='SOL';

UPDATE assets SET
  name='Cardano',
  chain='Cardano',
  decimals=6,
  compliance_status='REVIEW',
  compliance_reason='Staking model; placeholder',
  updated_at=datetime('now')
WHERE symbol='ADA';

UPDATE assets SET
  name='BNB Chain',
  chain='BNB Chain',
  decimals=18,
  compliance_status='EXCLUDE',
  compliance_reason='Issuer/control risk; placeholder',
  updated_at=datetime('now')
WHERE symbol='BNB';

-- 5. Insert BTC holding
WITH demo AS (
  SELECT p.id AS portfolio_id
  FROM portfolios p
  JOIN users u ON p.user_id = u.id
  WHERE u.email = 'user@example.com'
    AND p.name = 'Demo'
)
INSERT OR IGNORE INTO portfolio_holdings (portfolio_id, asset_symbol, amount)
SELECT demo.portfolio_id, 'BTC', '0.05000000' FROM demo;

-- 6. Update BTC holding
UPDATE portfolio_holdings
SET amount='0.05000000', updated_at=datetime('now')
WHERE asset_symbol='BTC'
  AND portfolio_id IN (
    SELECT p.id
    FROM portfolios p
    JOIN users u ON p.user_id = u.id
    WHERE u.email='user@example.com' AND p.name='Demo'
  );

-- 7. Insert ETH holding
WITH demo AS (
  SELECT p.id AS portfolio_id
  FROM portfolios p
  JOIN users u ON p.user_id = u.id
  WHERE u.email = 'user@example.com'
    AND p.name = 'Demo'
)
INSERT OR IGNORE INTO portfolio_holdings (portfolio_id, asset_symbol, amount)
SELECT demo.portfolio_id, 'ETH', '0.500000000000000000' FROM demo;

-- 8. Update ETH holding
UPDATE portfolio_holdings
SET amount='0.500000000000000000', updated_at=datetime('now')
WHERE asset_symbol='ETH'
  AND portfolio_id IN (
    SELECT p.id
    FROM portfolios p
    JOIN users u ON p.user_id = u.id
    WHERE u.email='user@example.com' AND p.name='Demo'
  );