# Modern Data Engineering with Databricks

Modern Data Engineering project based on the FIAP/Databricks practical material, focused on transforming raw sales data into an analytical Lakehouse architecture.

## Project objective

Build a data pipeline that transforms a raw `vendas.csv` file through the Medallion Architecture:

```text
Raw CSV
  ↓
Bronze — faithful raw copy
  ↓
Silver — cleaned and validated data
  ↓
Gold — analytical model
  ↓
Star Schema + business queries
```

## Technologies

- Databricks
- PySpark
- SQL
- Delta Lake
- Medallion Architecture
- Star Schema

## Architecture

| Layer | Purpose |
|---|---|
| Bronze | Preserve the source data as a faithful Delta copy |
| Silver | Select relevant columns, standardize types, remove duplicates and apply data-quality rules |
| Gold | Create dimensions and a fact table for analytical queries |

## Project structure

```text
modern-data-engineering-databricks/
├── 01-bronze/
├── 02-silver/
├── 03-gold/
├── 04-databricks/
├── 05-data-quality/
└── docs/
```

## Practice scope

The source material uses a sales CSV with 50,000 rows and 40 columns and guides the construction of a Bronze Delta table, a cleaned Silver table, four dimensions and one fact table.

The repository documents the practical implementation as it is executed in Databricks. Results will only be added after validation in the Databricks environment.

## Status

**In development — Databricks practice in progress.**

## Reference

Project based on the FIAP material *Modern Data Architecture and Engineering — Introdução a Databricks*.
