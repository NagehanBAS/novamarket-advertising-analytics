
-- NovaMarket Advertising Analytics
-- Task 4: Compare JOIN types between orders and sessions.
-- Database: SQLite
--
-- Expected row counts:
-- INNER JOIN: 12
-- LEFT JOIN: 12
-- RIGHT JOIN: 15
-- FULL OUTER JOIN: 15

-- 1. INNER JOIN: Only orders with matching sessions.
SELECT
    o.date_date,
    o.orders_id,
    o.turnover,
    o.news,
    o.session_id,
    s.campaign_key,
    s.campaign
FROM nova_orders AS o
INNER JOIN nova_sessions AS s
    ON o.session_id = s.session_id
ORDER BY o.orders_id;

-- 2. LEFT JOIN: Preserve all orders.
SELECT
    o.date_date,
    o.orders_id,
    o.turnover,
    o.news,
    o.session_id,
    s.campaign_key,
    s.campaign
FROM nova_orders AS o
LEFT JOIN nova_sessions AS s
    ON o.session_id = s.session_id
ORDER BY o.orders_id;

-- 3. RIGHT JOIN: Preserve all sessions.
SELECT
    o.date_date,
    o.orders_id,
    o.turnover,
    o.news,
    s.session_id,
    s.campaign_key,
    s.campaign
FROM nova_orders AS o
RIGHT JOIN nova_sessions AS s
    ON o.session_id = s.session_id
ORDER BY s.session_id;

-- 4. FULL OUTER JOIN: Preserve all orders and sessions.
SELECT
    COALESCE(o.date_date, s.date_date) AS date_date,
    o.orders_id,
    o.turnover,
    o.news,
    COALESCE(o.session_id, s.session_id) AS session_id,
    s.campaign_key,
    s.campaign
FROM nova_orders AS o
FULL OUTER JOIN nova_sessions AS s
    ON o.session_id = s.session_id
ORDER BY session_id;
