
-- NovaMarket Advertising Analytics
-- Task 9: Analyze monthly advertising performance by paid source.
-- Database: SQLite
-- The sample dataset covers February 1-3, 2026 only.
-- NULLIF prevents division-by-zero errors.

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
),

campaign_performance AS (
    SELECT
        c.date_date,
        c.paid_source,
        c.campaign_key,
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
),

monthly_summary AS (
    SELECT
        strftime('%Y-%m', date_date) AS month,
        paid_source,
        ROUND(SUM(turnover), 2) AS turnover,
        SUM(nb_transactions) AS nb_transactions,
        SUM(news) AS news,
        ROUND(SUM(cost), 2) AS cost,
        SUM(impression) AS impression,
        SUM(click) AS click
    FROM campaign_performance
    GROUP BY
        strftime('%Y-%m', date_date),
        paid_source
)

SELECT
    month,
    paid_source,
    turnover,
    nb_transactions,
    news,
    cost,
    impression,
    click,
    ROUND(turnover * 1.0 / NULLIF(cost, 0), 2) AS ROAS,
    ROUND(cost * 1.0 / NULLIF(news, 0), 2) AS CAC,
    ROUND(cost * 1000.0 / NULLIF(impression, 0), 2) AS CPM,
    ROUND(cost * 1.0 / NULLIF(click, 0), 2) AS CPC,
    ROUND(click * 100.0 / NULLIF(impression, 0), 2) AS CTR
FROM monthly_summary
ORDER BY month, paid_source;
