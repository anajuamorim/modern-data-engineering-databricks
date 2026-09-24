# 01 — Bronze Layer

The Bronze layer is the first Delta representation of the source data.

## Objective

Preserve the CSV data as faithfully as possible so it can be reprocessed, audited and traced back to the original source.

## Flow

```text
vendas.csv → Spark / PySpark → bronze_vendas
```

## Source path

```text
/Volumes/workspace/default/aula_databricks/vendas.csv
```

## Read the CSV

```python
caminho_csv = "/Volumes/workspace/default/aula_databricks/vendas.csv"

df_csv = (
    spark.read
    .option("header", "true")
    .option("inferSchema", "true")
    .option("sep", ",")
    .csv(caminho_csv)
)

display(df_csv)
df_csv.printSchema()
df_csv.count()
len(df_csv.columns)
df_csv.columns
```

## Write Bronze

```python
(
    df_csv.write
    .mode("overwrite")
    .saveAsTable("workspace.default.bronze_vendas")
)
```

## Delta history

```sql
DESCRIBE HISTORY workspace.default.bronze_vendas;
```

> Execution results will be added after validation in Databricks.
