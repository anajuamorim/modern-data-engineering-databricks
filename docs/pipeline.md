# End-to-End Pipeline

## Objective

Transform the raw sales CSV into an analytical model using the Lakehouse approach.

```text
CSV
 ↓
Volume
 ↓
Bronze
 ↓
Silver
 ↓
Gold
 ↓
Star Schema
 ↓
Business Analysis
```

## Bronze

The Bronze layer preserves the source data as a Delta table.

Main responsibilities:

- read the CSV from the Databricks Volume;
- preserve the original structure;
- persist the raw dataset as `workspace.default.bronze_vendas`;
- keep Delta history available for auditing and recovery.

Implementation: `04-databricks/01_bronze_ingestion.py`.

## Silver

The Silver layer prepares the data for trusted analytical use.

Transformations documented in this project include:

- selecting the business columns;
- converting `data` to a date;
- standardizing `loja_uf`;
- converting `valor_venda` to decimal;
- removing duplicate `id_venda`;
- keeping sales with positive `valor_venda`.

Implementation: `02-silver/01_silver_transformation.py`.

## Gold

The Gold layer organizes the data for business analysis.

The project creates four dimensions:

- product;
- store;
- customer;
- time.

It also creates the sales fact table.

Implementation: `03-gold/01_star_schema.sql`.

## Data Quality

The repository includes checks for:

- row counts;
- duplicate sale identifiers;
- invalid revenue values;
- orphan product, store and customer keys;
- Delta table history.

Implementation: `05-data-quality/01_quality_checks.sql`.

## Important execution rule

This repository separates **code/documentation** from **execution evidence**.

No row counts, query results or validation outcomes should be described as observed until the corresponding code has actually been executed in Databricks.
