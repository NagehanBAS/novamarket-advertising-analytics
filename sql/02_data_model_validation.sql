
-- NovaMarket Advertising Analytics
-- Tasks 2 and 3: Validate primary keys and data relationships.
-- Database: SQLite
-- Duplicate checks should return zero rows.

-- Test 1: Order ID uniqueness.
SELECT
    orders_id,
    COUNT(*) AS duplicate_count
FROM nova_orders
GROUP BY orders_id
HAVING COUNT(*) > 1;

-- Test 2: Session ID uniqueness.
SELECT
    session_id,
    COUNT(*) AS duplicate_count
FROM nova_sessions
GROUP BY session_id
HAVING COUNT(*) > 1;

-- Test 3: Daily campaign key uniqueness across paid sources.
WITH all_campaigns AS (
    SELECT 'google_ads' AS paid_source, date_date, campaign_key
    FROM nova_google_ads

    UNION ALL

    SELECT 'bing_ads', date_date, campaign_key
    FROM nova_bing_ads

    UNION ALL

    SELECT 'criteo', date_date, campaign_key
    FROM nova_criteo_ads

    UNION ALL

    SELECT
        'meta_ads',
        date_date,
        CASE
            WHEN campaign_key LIKE 'META_%' THEN campaign_key
            ELSE campaign_name
        END
    FROM nova_meta_ads
)
SELECT
    paid_source,
    date_date,
    campaign_key,
    COUNT(*) AS duplicate_count
FROM all_campaigns
GROUP BY paid_source, date_date, campaign_key
HAVING COUNT(*) > 1;

-- Test 4: Orders without a matching session.
SELECT
    o.orders_id,
    o.session_id
FROM nova_orders AS o
LEFT JOIN nova_sessions AS s
    ON o.session_id = s.session_id
WHERE s.session_id IS NULL;

-- Test 5: Sessions without an associated order.
-- These are valid non-converting sessions.
SELECT
    s.session_id,
    s.campaign_key
FROM nova_sessions AS s
LEFT JOIN nova_orders AS o
    ON s.session_id = o.session_id
WHERE o.orders_id IS NULL
ORDER BY s.session_id;
