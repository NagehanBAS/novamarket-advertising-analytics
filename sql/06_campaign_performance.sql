
-- NovaMarket Advertising Analytics
-- Task 7: Combine campaign advertising costs with order performance.
-- Database: SQLite
-- Expected result: 19 campaign-day records.
-- LEFT JOIN preserves campaigns without conversions.

WITH campaign_costs AS (
    SELECT
        date_date, paid_source, campaign_key,
        campaign_name, cost, impression, click
    FROM nova_google_ads

    UNION ALL

    SELECT
        date_date, paid_source, campaign_key,
        campaign_name, cost, impression, click
    FROM nova_bing_ads

    UNION ALL

    SELECT
        date_date, paid_source, campaign_key,
        campaign_name, cost, impression, click
    FROM nova_criteo_ads

    UNION ALL

    SELECT
        date_date,
        paid_source,
        CASE
            WHEN campaign_key LIKE 'META_%'
                THEN campaign_key
            ELSE campaign_name
        END AS campaign_key,
        CASE
            WHEN campaign_key LIKE 'META_%'
                THEN campaign_name
            ELSE campaign_key
        END AS campaign_name,
        cost,
        impression,
        click
    FROM nova_meta_ads
),

orders_sessions AS (
    SELECT
        o.date_date,
        o.orders_id,
        o.turnover,
        o.news,
        s.campaign_key
    FROM nova_orders AS o
    INNER JOIN nova_sessions AS s
        ON o.session_id = s.session_id
),

orders_campaign AS (
    SELECT
        date_date,
        campaign_key,
        COUNT(DISTINCT orders_id) AS nb_transactions,
        ROUND(SUM(turnover), 2) AS turnover,
        SUM(news) AS news
    FROM orders_sessions
    GROUP BY date_date, campaign_key
)

SELECT
    c.date_date,
    c.paid_source,
    c.campaign_key,
    c.campaign_name,
    c.cost,
    c.impression,
    c.click,
    COALESCE(o.nb_transactions, 0) AS nb_transactions,
    COALESCE(o.turnover, 0) AS turnover,
    COALESCE(o.news, 0) AS news
FROM campaign_costs AS c
LEFT JOIN orders_campaign AS o
    ON c.date_date = o.date_date
    AND c.campaign_key = o.campaign_key
ORDER BY c.date_date, c.paid_source, c.campaign_key;
