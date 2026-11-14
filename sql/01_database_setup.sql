
-- NovaMarket Advertising Analytics
-- Task 1: Create and populate advertising, session, and order tables.
-- Database: SQLite

DROP TABLE IF EXISTS nova_google_ads;
DROP TABLE IF EXISTS nova_bing_ads;
DROP TABLE IF EXISTS nova_criteo_ads;
DROP TABLE IF EXISTS nova_meta_ads;
DROP TABLE IF EXISTS nova_orders;
DROP TABLE IF EXISTS nova_sessions;

CREATE TABLE nova_google_ads (
    date_date DATE,
    paid_source TEXT,
    campaign_key TEXT,
    campaign_name TEXT,
    cost NUMERIC(10,2),
    impression INTEGER,
    click INTEGER
);

CREATE TABLE nova_bing_ads (
    date_date DATE,
    paid_source TEXT,
    campaign_key TEXT,
    campaign_name TEXT,
    cost NUMERIC(10,2),
    impression INTEGER,
    click INTEGER
);

CREATE TABLE nova_criteo_ads (
    date_date DATE,
    paid_source TEXT,
    campaign_key TEXT,
    campaign_name TEXT,
    cost NUMERIC(10,2),
    impression INTEGER,
    click INTEGER
);

CREATE TABLE nova_meta_ads (
    date_date DATE,
    paid_source TEXT,
    campaign_key TEXT,
    campaign_name TEXT,
    cost NUMERIC(10,2),
    impression INTEGER,
    click INTEGER
);

CREATE TABLE nova_orders (
    date_date DATE,
    orders_id INTEGER,
    news INTEGER,
    turnover NUMERIC(10,2),
    session_id TEXT
);

CREATE TABLE nova_sessions (
    date_date DATE,
    session_id TEXT,
    campaign_key TEXT,
    campaign TEXT,
    channel_grouping TEXT,
    channel TEXT
);

INSERT INTO nova_google_ads VALUES
('2026-02-01','google_ads','GGL_BRAND_TR','Brand Search TR',1200.50,15000,820),
('2026-02-01','google_ads','GGL_GENERIC_SQL','SQL Course Search',980.00,11200,540),
('2026-02-02','google_ads','GGL_BRAND_TR','Brand Search TR',1310.75,15800,860),
('2026-02-02','google_ads','GGL_GENERIC_SQL','SQL Course Search',1025.40,11850,575),
('2026-02-03','google_ads','GGL_DS_BOOTCAMP','Data Science Bootcamp',890.20,9700,410);

INSERT INTO nova_bing_ads VALUES
('2026-02-01','bing_ads','BNG_BRAND_TR','Brand Search Bing',420.00,4800,210),
('2026-02-01','bing_ads','BNG_GENERIC_SQL','SQL Training Bing',350.50,3900,165),
('2026-02-02','bing_ads','BNG_BRAND_TR','Brand Search Bing',460.00,5050,225),
('2026-02-02','bing_ads','BNG_GENERIC_SQL','SQL Training Bing',370.25,4100,172),
('2026-02-03','bing_ads','BNG_DS_BOOTCAMP','Data Science Bing',315.80,3600,140);

INSERT INTO nova_criteo_ads VALUES
('2026-02-01','criteo','CRT_RETARGETING','Retargeting Visitors',610.00,22000,340),
('2026-02-02','criteo','CRT_RETARGETING','Retargeting Visitors',645.25,22800,355),
('2026-02-03','criteo','CRT_RETARGETING','Retargeting Visitors',590.40,21000,330),
('2026-02-03','criteo','CRT_CART_RECOVERY','Cart Recovery',410.10,12400,205);

INSERT INTO nova_meta_ads VALUES
('2026-02-01','meta_ads','SQL Lead Campaign','META_SQL_LEADS',1500.00,35000,920),
('2026-02-01','meta_ads','META_DS_LEADS','Data Science Lead Campaign',1380.75,30100,810),
('2026-02-02','meta_ads','META_SQL_LEADS','SQL Lead Campaign',1545.20,36200,955),
('2026-02-02','meta_ads','META_DS_LEADS','Data Science Lead Campaign',1410.00,30950,825),
('2026-02-03','meta_ads','META_REMARKETING','Remarketing Campaign',760.90,18500,290);

INSERT INTO nova_sessions VALUES
('2026-02-01','S001','GGL_BRAND_TR','Brand Search TR','Paid Search','Google Ads'),
('2026-02-01','S002','GGL_GENERIC_SQL','SQL Course Search','Paid Search','Google Ads'),
('2026-02-01','S003','META_SQL_LEADS','SQL Lead Campaign','Paid Social','Meta Ads'),
('2026-02-01','S004','CRT_RETARGETING','Retargeting Visitors','Display','Criteo'),
('2026-02-01','S005','BNG_BRAND_TR','Brand Search Bing','Paid Search','Bing Ads'),
('2026-02-02','S006','GGL_BRAND_TR','Brand Search TR','Paid Search','Google Ads'),
('2026-02-02','S007','META_DS_LEADS','Data Science Lead Campaign','Paid Social','Meta Ads'),
('2026-02-02','S008','CRT_RETARGETING','Retargeting Visitors','Display','Criteo'),
('2026-02-02','S009','BNG_GENERIC_SQL','SQL Training Bing','Paid Search','Bing Ads'),
('2026-02-02','S010','GGL_GENERIC_SQL','SQL Course Search','Paid Search','Google Ads'),
('2026-02-03','S011','META_REMARKETING','Remarketing Campaign','Paid Social','Meta Ads'),
('2026-02-03','S012','CRT_CART_RECOVERY','Cart Recovery','Display','Criteo'),
('2026-02-03','S013','GGL_DS_BOOTCAMP','Data Science Bootcamp','Paid Search','Google Ads'),
('2026-02-03','S014','BNG_DS_BOOTCAMP','Data Science Bing','Paid Search','Bing Ads'),
('2026-02-03','S015',NULL,'Direct Visit','Direct','Direct');

INSERT INTO nova_orders VALUES
('2026-02-01',1001,1,4200.00,'S001'),
('2026-02-01',1002,0,3100.00,'S003'),
('2026-02-01',1003,1,2750.00,'S004'),
('2026-02-01',1004,0,1800.00,'S005'),
('2026-02-02',1005,1,4600.00,'S006'),
('2026-02-02',1006,0,2950.00,'S007'),
('2026-02-02',1007,1,2100.00,'S009'),
('2026-02-02',1008,0,3300.00,'S010'),
('2026-02-03',1009,1,3900.00,'S011'),
('2026-02-03',1010,0,2400.00,'S012'),
('2026-02-03',1011,1,5100.00,'S013'),
('2026-02-03',1012,0,1700.00,'S015');

-- Verify imported row counts.
SELECT 'Google Ads' AS source, COUNT(*) AS row_count FROM nova_google_ads
UNION ALL
SELECT 'Bing Ads', COUNT(*) FROM nova_bing_ads
UNION ALL
SELECT 'Criteo', COUNT(*) FROM nova_criteo_ads
UNION ALL
SELECT 'Meta Ads', COUNT(*) FROM nova_meta_ads
UNION ALL
SELECT 'Orders', COUNT(*) FROM nova_orders
UNION ALL
SELECT 'Sessions', COUNT(*) FROM nova_sessions;
