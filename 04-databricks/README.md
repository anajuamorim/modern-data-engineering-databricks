# 04 — Databricks

This section documents the Databricks environment used by the practical exercise.

## Volume

```sql
CREATE VOLUME IF NOT EXISTS workspace.default.aula_databricks;
```

The source CSV is uploaded to:

```text
/Volumes/workspace/default/aula_databricks/vendas.csv
```

## Main concepts

**Volume:** stores the source file.

**Table:** stores modeled data after transformation.

**Delta Lake:** provides the table format used across the layers, including capabilities covered by the material such as ACID transactions, time travel and schema enforcement.

The practical material uses Databricks Free Edition with notebooks, serverless compute, PySpark and SQL.

> This repository documents the implementation and does not claim execution until it is validated in Databricks.
