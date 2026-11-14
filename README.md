# NovaMarket | Advertising & Marketing Performance Analytics

### Multi-Channel Marketing Analytics with SQL

An end-to-end SQL analytics project evaluating advertising performance across Google Ads, Bing Ads, Criteo, and Meta Ads.

The project integrates advertising costs, website sessions, and e-commerce orders to build campaign-level performance reporting and calculate key marketing metrics, including **ROAS, CAC, CPM, CPC, and CTR**.

## Project Overview

NovaMarket is a fictional online marketplace offering organic and sustainable products. As an e-commerce-only business, digital advertising plays a central role in customer acquisition and revenue generation.

The marketing team's challenge is to maximize advertising efficiency while allocating limited budgets across multiple paid media channels.

This project transforms fragmented advertising and transactional datasets into an integrated marketing performance reporting model.

**Key business questions:**

- Which advertising channel generates the highest return on ad spend?
- Which channel acquires new customers at the lowest cost?
- How efficiently do advertising impressions generate clicks?
- Which paid sources generate revenue and conversions?
- Which campaigns incur advertising costs without generating orders?
- How can marketing performance be monitored by campaign, channel, and reporting period?

## Technology Stack

- **SQLite** — Relational database
- **SQL** — Data preparation and analytical queries
- **Common Table Expressions (CTEs)** — Modular analytical transformations
- **INNER JOIN and LEFT JOIN** — Session attribution and campaign performance integration
- **RIGHT JOIN and FULL OUTER JOIN** — Relational data exploration
- **UNION ALL** — Multi-platform advertising data consolidation
- **CASE WHEN** — Campaign data standardization
- **GROUP BY and aggregate functions** — Campaign and channel-level reporting
- **COALESCE and NULLIF** — Missing-value handling and safe KPI calculations
- **GitHub** — Version control and documentation

## Dataset Overview

The project uses six educational source tables.

| Table | Description | Records |
|---|---|---:|
| `nova_google_ads` | Google Ads campaign performance | 5 |
| `nova_bing_ads` | Bing Ads campaign performance | 5 |
| `nova_criteo_ads` | Criteo campaign performance | 4 |
| `nova_meta_ads` | Meta Ads campaign performance | 5 |
| `nova_orders` | E-commerce transactions and customer acquisition indicators | 12 |
| `nova_sessions` | Website sessions and campaign attribution information | 15 |

**Analysis period:** February 1–3, 2026

**Total advertising records:** 19

The repository includes the SQL statements necessary to recreate the sample dataset.

## Data Model & Attribution Logic

The project connects advertising expenditure with e-commerce revenue through website sessions.

**Data relationship:**

Advertising Campaigns → Website Sessions → Customer Orders

Campaign performance records are matched with sessions using:

`date_date + campaign_key`

Orders are associated with sessions using:

`session_id`

### Key Relationships

| Dataset | Key | Relationship |
|---|---|---|
| Advertising tables | `date_date + campaign_key` | Campaign-day uniqueness within each paid source |
| `nova_sessions` | `session_id` | Identifies website sessions |
| `nova_orders` | `orders_id` | Identifies individual orders |
| Sessions → Orders | `session_id` | Links orders to their originating sessions |

The sample contains 15 website sessions and 12 orders.

Three sessions did not generate orders: `S002`, `S008`, and `S014`.

One order originated from a direct visit without an associated paid campaign key.

## Analytical Workflow

### 1. Data Preparation and Validation

Six source tables are created and populated in SQLite.

Primary key uniqueness is verified for:

- `orders_id` in `nova_orders`
- `session_id` in `nova_sessions`
- `date_date + campaign_key` within each advertising source

The validation checks did not identify duplicate keys in the sample data.

### 2. Orders and Sessions Integration

Orders are connected with website sessions to identify associated campaigns.

Four JOIN types are examined:

| JOIN Type | Returned Rows |
|---|---:|
| INNER JOIN | 12 |
| LEFT JOIN | 12 |
| RIGHT JOIN | 15 |
| FULL OUTER JOIN | 15 |

The INNER JOIN successfully matched all 12 orders with their sessions.

The RIGHT JOIN and FULL OUTER JOIN additionally preserved the three sessions without orders.

### 3. Advertising Data Consolidation

Google Ads, Bing Ads, Criteo, and Meta Ads data are combined using `UNION ALL`.

This transformation preserves all 19 campaign-day advertising records.

A `CASE WHEN` expression standardizes an inconsistent campaign identifier in the source Meta Ads data without changing the original records.

### 4. Campaign-Level Order Aggregation

Orders are aggregated by:

- `date_date`
- `campaign_key`

The following metrics are calculated:

- `nb_transactions` — Number of distinct orders
- `turnover` — Total attributed revenue
- `news` — Number of new customers represented in the sample

### 5. Advertising Cost and Revenue Integration

Campaign costs are joined with campaign-level order performance using `date_date` and `campaign_key`.

A LEFT JOIN preserves advertising campaigns even when they generate no orders.

`COALESCE` replaces missing transaction, revenue, and new-customer metrics with zero.

The resulting campaign performance dataset contains 19 records.

### 6. Paid Source Performance Analysis

Campaign performance is aggregated by `paid_source` to evaluate marketing efficiency across channels.

### 7. Monthly Performance Reporting

Advertising performance is grouped by month and paid source using SQLite's `strftime()` function.

The resulting reporting structure supports month-level KPI analysis when additional reporting periods become available.

## Marketing KPI Framework

| KPI | Formula | Business Interpretation |
|---|---|---|
| ROAS | Advertising Revenue / Advertising Cost | Revenue generated per unit of ad spend |
| CAC | Advertising Cost / New Customers | Acquisition cost per new customer |
| CPM | Advertising Cost / Impressions × 1,000 | Cost per thousand impressions |
| CPC | Advertising Cost / Clicks | Cost per click |
| CTR | Clicks / Impressions × 100 | Percentage of impressions resulting in clicks |

`NULLIF` is used to avoid division-by-zero errors.

All KPI calculations are based on aggregated campaign and paid source totals rather than unweighted averages of individual campaign ratios.

## Advertising Performance Results

### Paid Source KPI Comparison

| Paid Source | Attributed Revenue | Advertising Cost | Orders | New Customers |
|---|---:|---:|---:|---:|
| Google Ads | 17,200.00 | 5,406.85 | 4 | 3 |
| Bing Ads | 3,900.00 | 1,916.55 | 2 | 1 |
| Criteo | 5,150.00 | 2,255.75 | 2 | 1 |
| Meta Ads | 9,950.00 | 6,596.85 | 3 | 1 |
| **Total** | **36,200.00** | **16,176.00** | **11** | **6** |

The paid advertising report excludes the direct-visit order, which has no paid campaign attribution.

### Marketing Efficiency KPIs

| Paid Source | ROAS | CAC | CPM | CPC | CTR |
|---|---:|---:|---:|---:|---:|
| Google Ads | **3.18** | **1,802.28** | 85.08 | 1.69 | **5.04%** |
| Bing Ads | 2.03 | 1,916.55 | 89.35 | 2.10 | 4.25% |
| Criteo | 2.28 | 2,255.75 | **28.85** | 1.83 | 1.57% |
| Meta Ads | 1.51 | 6,596.85 | 43.76 | 1.74 | 2.52% |

*Financial values are reported in dataset units; no currency designation is assumed.*

## Business Insights

### 1. Google Ads Leads in Revenue Efficiency

Google Ads achieved the highest ROAS at **3.18**, generating 3.18 units of attributed revenue per unit of advertising expenditure.

It also delivered the highest CTR at **5.04%** and the lowest CAC at **1,802.28**.

Google Ads was the strongest-performing acquisition channel in the observed sample.

**Business implication:** Evaluate whether incremental budget allocation to high-performing Google Ads campaigns could improve overall marketing efficiency.

### 2. Meta Ads Shows the Greatest Optimization Opportunity

Meta Ads recorded the highest advertising expenditure at **6,596.85** but delivered the lowest ROAS at **1.51**.

Its CAC of **6,596.85** was also substantially higher than that of other channels.

**Business implication:** Review campaign targeting, creative effectiveness, acquisition objectives, and conversion performance before increasing spend.

### 3. Criteo Demonstrates Relatively Efficient Revenue Generation

Criteo achieved a ROAS of **2.28**, the second highest among the four platforms.

It also delivered the lowest CPM at **28.85**, although its CTR of **1.57%** was the lowest.

**Business implication:** Assess retargeting audience quality and post-click conversions rather than relying on CTR alone.

### 4. Bing Ads Provides a Smaller-Scale Acquisition Channel

Bing Ads generated a ROAS of **2.03** with advertising costs of **1,916.55**.

Its CTR reached **4.25%**, indicating engagement despite its smaller scale.

**Business implication:** Investigate campaign-level opportunities to improve conversion efficiency while maintaining cost control.

### 5. Campaigns Without Orders Still Incur Advertising Costs

The campaign-level LEFT JOIN preserved paid campaigns with zero attributed orders.

This is essential for understanding advertising inefficiency: excluding non-converting campaigns would distort marketing performance metrics.

**Business implication:** Monitor campaign expenditure alongside conversion and revenue metrics to identify underperforming budget allocations.

## Monthly Performance Analysis

The monthly SQL model groups advertising performance by reporting month and paid source.

**Available reporting month:** February 2026

The dataset covers only February 1–3, 2026.

Therefore, the monthly reporting output contains four rows, one for each advertising platform.

Because no other month is represented, meaningful month-over-month growth or decline cannot be established from this sample.

The reporting structure can support time-series comparisons when additional monthly data becomes available.

## Data Quality & Analytical Considerations

The analysis incorporates several data quality and modeling controls:

- Uniqueness validation for order and session identifiers
- Campaign-day key validation
- JOIN type comparisons
- Identification of sessions without orders
- Preservation of non-converting paid campaigns
- Campaign key standardization
- NULL-safe performance metrics
- Division-by-zero protection using `NULLIF`

**Important considerations:**

- The dataset is a small educational sample, not a production advertising dataset.
- Revenue attribution relies on recorded session-to-campaign relationships.
- Attributed revenue does not independently establish incremental advertising impact.
- Direct-visit revenue is excluded from paid campaign performance calculations.
- The three-day reporting period limits trend analysis and generalizability.

## Repository Structure

```text
novamarket-advertising-analytics/
├── README.md
└── sql/
    ├── 01_database_setup.sql
    ├── 02_data_model_validation.sql
    ├── 03_orders_sessions_joins.sql
    ├── 04_unified_campaign_costs.sql
    ├── 05_campaign_order_summary.sql
    ├── 06_campaign_performance.sql
    ├── 07_paid_source_kpis.sql
    └── 08_monthly_advertising_performance.sql
```

## SQL Scripts

| File | Purpose |
|---|---|
| `01_database_setup.sql` | Create and populate advertising, session, and order tables |
| `02_data_model_validation.sql` | Validate primary keys and relationships |
| `03_orders_sessions_joins.sql` | Compare INNER, LEFT, RIGHT, and FULL OUTER JOIN |
| `04_unified_campaign_costs.sql` | Combine and standardize advertising data |
| `05_campaign_order_summary.sql` | Aggregate transactions and revenue by campaign |
| `06_campaign_performance.sql` | Connect campaign expenditure with attributed orders |
| `07_paid_source_kpis.sql` | Calculate marketing efficiency metrics by channel |
| `08_monthly_advertising_performance.sql` | Generate monthly paid source performance reporting |

## How to Run

1. Open [SQLite Online](https://sqliteonline.com/) or another compatible SQLite environment.
2. Execute `01_database_setup.sql` to create and populate the six source tables.
3. Run the remaining SQL scripts in numerical order.
4. Review the resulting JOIN comparisons and campaign-level outputs.
5. Inspect the paid source KPI report and monthly performance summary.

**Note:** The database setup script drops and recreates the six NovaMarket source tables. Run it in a suitable test environment rather than a production database.

The analytical queries use CTEs and do not require persistent intermediate tables.

## Skills Demonstrated

- Multi-channel marketing analytics
- Advertising performance measurement
- SQL data integration and transformation
- Campaign attribution modeling
- JOIN operations and relational modeling
- UNION ALL and data consolidation
- CTE-based analytical workflows
- Marketing KPI development
- ROAS and customer acquisition cost analysis
- Data quality validation
- Campaign and channel-level reporting
- Commercial performance interpretation
- Business-oriented SQL documentation

## Potential Extensions

Future development opportunities include:

- Interactive advertising performance dashboards
- Campaign-level budget optimization analysis
- Conversion rate monitoring
- Month-over-month performance comparisons
- Acquisition funnel analytics
- Automated paid media reporting
- Campaign profitability and customer lifetime value analysis

These are potential future enhancements rather than completed components of the current project.

## Project Context

This project was developed as part of a practical SQL and data analytics training program and documented as a business-oriented analytics portfolio case study.

Its purpose is to demonstrate how advertising expenditures, website sessions, and transaction data can be integrated into structured marketing intelligence that supports budget allocation and commercial decision-making.

---

**Tools:** SQLite · SQL · GitHub

**Focus Areas:** Marketing Analytics · Paid Media Performance · Customer Acquisition · Commercial Analytics · Campaign Attribution

## Author

**Nagehan Bas**
