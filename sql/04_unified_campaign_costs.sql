
-- NovaMarket Advertising Analytics
-- Task 5: Consolidate advertising costs across four platforms.
-- Database: SQLite
-- Expected result: 19 campaign-day records.

WITH campaign_costs AS (
    SELECT
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cost,
        impression,
        click
    FROM nova_google_ads

    UNION ALL

    SELECT
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cost,
        impression,
        click
    FROM nova_bing_ads

    UNION ALL

    SELECT
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cost,
        impression,
        click
    FROM nova_criteo_ads

    UNION ALL

    -- Standardize the inconsistent campaign fields in Meta Ads.
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
)

SELECT *
FROM campaign_costs
ORDER BY date_date, paid_source, campaign_key;
