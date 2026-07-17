<h1 align="center">🏦 Fintech Analytics Engineering Platform</h1>

<p align="center">
  <strong>dbt Cloud • BigQuery • Power BI • Mortgage Credit Risk</strong>
</p>

---

## 🚀 Overview

This portfolio project demonstrates an **end-to-end analytics engineering workflow** built using **dbt Cloud, BigQuery, and Power BI**, focused on **mortgage credit risk analytics**.

It shows how raw financial and macroeconomic data can be transformed into **tested, documented, BI-ready datasets and an interactive dashboard** using layered dbt models.

---

## 🖼 Screenshots

### 📊 Main Power BI Dashboard

![Main Dashboard](screenshots/powerbi_main_dashboard.png)

---

<details>
  <summary><strong>▶️ More screenshots (click to expand)</strong></summary>

#### 🗺️ Power BI – State Filter Example (NY)

![State Filter Example – NY](screenshots/powerbi_state_filter_ny.png)

#### 🧭 dbt DAG (Marts Layer)

![dbt Marts DAG](screenshots/dbt_dag_marts.png)

#### 📚 dbt Model Documentation

![dbt Model Docs 1](screenshots/dbt_docs_model_page1.png)

![dbt Model Docs 2](screenshots/dbt_docs_model_page2.png)

</details>

---

## 🎯 Problem Statement

Mortgage delinquency is a core risk metric for financial institutions.  
To analyze and monitor this risk effectively, teams need:

- 📊 Consistent loan-level and monthly performance data  
- 🧮 Clear definitions of delinquency metrics  
- ✅ Confidence in data quality and a clearly defined data snapshot
- 🔍 Transparent lineage from raw data to business dashboards  

This project simulates how an analytics engineering team would design and operate such a system.

---

## 🧰 Tech Stack

| Layer | Tool |
|-----|-----|
| Data Warehouse | BigQuery |
| Transformations | dbt Cloud |
| Source Data | Freddie Mac, FRED |
| Orchestration | dbt Cloud Deploy Job |
| Documentation | dbt Cloud Catalog |
| BI / Visualization | Power BI |

---

## 🏗️ Architecture & Data Flow

```
Sources
  ↓
Staging (stg_)
  ↓
Intermediate (int_)
  ↓
Marts (fct_)
  ↓
Exposure (Power BI Dashboard)
```

---

## 🗄️ Data Sources

### Raw Inputs Used for the Project Snapshot

- **Freddie Mac Single-Family Loan-Level Dataset (Acquisition)**  
  https://www.freddiemac.com/research/dataset/single-family-loan-level-dataset

- **Freddie Mac Single-Family Loan-Level Dataset (Monthly Performance)**  
  https://www.freddiemac.com/research/dataset/single-family-loan-level-dataset

- **FRED 30-Year Fixed Mortgage Rate (MORTGAGE30US)**  
  https://fred.stlouisfed.org/series/MORTGAGE30US

The inspection notebook references Freddie Mac's Q1 2025 acquisition and monthly-performance files, while the dashboard presents January through June 2025. The FRED source includes a freshness rule in dbt; the historical Freddie Mac snapshot is static and is not monitored as a live feed.

### Reproducibility Boundary

The repository includes the dbt transformation project, documentation, tests, Power BI file, and screenshots. The raw Freddie Mac files and populated BigQuery source tables are not included. Re-running the project therefore requires obtaining the source data, loading tables matching the declared source schemas, and supplying a dbt profile for BigQuery.

---

## 🧹 Staging Models (stg_)

Purpose: Create clean, predictable inputs.

- One-to-one with source tables  
- Renaming generic columns  
- Explicit type casting  
- Light date parsing  
- No joins or aggregations  

---

## 🧠 Intermediate Models (int_)

Purpose: Reusable business logic.

- `int_loan_monthly` aligns data to the loan-month grain  
- `int_delinquency_flags_monthly` centralizes delinquency logic  

This prevents logic duplication and improves maintainability.

---

## 📊 Mart Models (fct_)

BI-ready fact tables:

- `fct_delinquency_monthly`
- `fct_delinquency_by_credit_band_monthly`
- `fct_delinquency_by_servicer_monthly`

Each mart includes:
- Loan-month counts  
- Delinquency metrics  
- Aggregations by time, geography, channel, credit band, or servicer  

Dimensions are embedded directly to simplify BI usage.

---

## ✅ Data Quality & Testing

The repository includes:

- not_null and unique tests  
- Singular grain test ensuring loan-month uniqueness  
- A configured freshness rule for the monthly FRED source

The included dbt Catalog screenshot records 8 successful models and 24 passing tests at project completion. It also records data freshness as unknown, so this repository does not claim active freshness monitoring for the completed snapshot.

---

## ♻️ Reusable Logic

A reusable dbt macro standardizes credit score banding logic and is reused across marts to ensure consistency.

---

## 📚 Documentation

Core models, selected columns, tests, and the Power BI exposure are documented in YAML and rendered via **dbt Cloud Catalog**.

Documentation includes:

- Full lineage graph  
- Model and column descriptions  
- Test coverage and results  
- Exposure definitions  

Docs are generated via a deploy job.

---

## 📦 Deployment & Environments

- Development environment for IDE work  
- Deployment environment used for a production-style project run

The project workflow was designed to run:

- dbt build  
- tests  
- source freshness checks  
- documentation generation  

The dbt Cloud job configuration is not stored in this repository, and the completed historical snapshot is not scheduled for ongoing ingestion.

---

## 🧠 Design Decisions

| Decision | Reason |
|------|------|
| No incremental models | Static dataset |
| No snapshots | No SCD need + free-tier constraints |
| No dim tables | Dimensions are simple and BI-friendly |
| No scheduler | Demonstrates readiness without simulating live ingestion |

---

## 🧪 Example Use Cases

- Track delinquency trends over time  
- Compare delinquency by credit quality  
- Identify higher-risk servicers  
- Analyze macro rate context alongside loan performance  

---

## 🔌 Exposure

A dbt exposure represents the downstream Power BI dashboard:

- Explicit ownership  
- Business context  
- A dependency on the mart used by the published dashboard

The credit-band and servicer marts remain available for additional analysis but are not presented as dependencies of the included dashboard.

---

## 📊 Power BI Dashboard – U.S. Mortgage Delinquency

This project includes a Power BI dashboard that visualizes:

- loan-month observation volume (shown on the original dashboard as “Total Loans”)
- delinquent loan-month observations (shown as “Delinquent Loans”)
- delinquency rate by month
- lending channels (Broker, Correspondent, Retail)  
- optional drill-down by U.S. state  

The dashboard is built directly on top of the curated mart:

```
fct_delinquency_monthly
```

### Metric Interpretation

The mart is aggregated from one record per loan per reporting month. A loan can therefore contribute multiple observations across January–June. The dashboard's volume cards should be interpreted as **loan-month observations**, not distinct loans. Delinquency rate is calculated as delinquent loan-month observations divided by total loan-month observations within the selected filters.

**[Download the Power BI dashboard (.pbix)](powerbi/fintech-ae-powerbi.pbix)**

Data sources visualized:

- Freddie Mac Single-Family Loan-Level dataset  
- FRED 30-Year Fixed Mortgage Rate (MORTGAGE30US)

---

## ⭐ Final Note

This project prioritizes **clarity, correctness, and maintainability**, reflecting real-world analytics engineering judgment.
