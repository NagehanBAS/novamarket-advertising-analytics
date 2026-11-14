
-- NovaMarket Advertising Analytics
-- Task 6: Aggregate order performance by date and campaign.
-- Database: SQLite

WITH orders_sessions AS (
    SELECT
        o.date_date,
        o.orders_id,
        o.turnover,
        o.news,
        s.campaign_key
    FROM nova_orders AS o
    INNER JOIN nova_sessions AS s
        ON o.session_id = s.session_id
)

SELECT
    date_date,
    campaign_key,
    COUNT(DISTINCT orders_id) AS nb_transactions,
    ROUND(SUM(turnover), 2) AS turnover,
    SUM(news) AS news
FROM orders_sessions
GROUP BY date_date, campaign_key
ORDER BY date_date, campaign_key;
