# 02 — Silver Layer

The Silver layer transforms the Bronze data into a cleaner and more reliable dataset.

## Transformations

- Select relevant columns
- Convert `data` to date
- Standardize `loja_uf`
- Cast `valor_venda` to decimal
- Remove duplicate sales by `id_venda`
- Keep sales with positive `valor_venda`

## PySpark

```python
from pyspark.sql import functions as F

colunas = [
    "id_venda", "data", "sku", "produto_nome", "categoria", "marca",
    "id_loja", "loja_nome", "loja_cidade", "loja_uf", "loja_regiao",
    "id_cliente", "cliente_faixa_etaria", "cliente_cidade",
    "cliente_segmento", "quantidade", "valor_unitario", "desconto",
    "valor_venda",
]

df_prata = (
    spark.table("workspace.default.bronze_vendas")
    .select(*colunas)
    .withColumn("data", F.to_date("data"))
    .withColumn("loja_uf", F.upper(F.trim("loja_uf")))
    .withColumn("valor_venda", F.col("valor_venda").cast("decimal(12,2)"))
    .dropDuplicates(["id_venda"])
    .filter(F.col("valor_venda") > 0)
)

(
    df_prata.write
    .mode("overwrite")
    .saveAsTable("workspace.default.prata_vendas")
)
```

> Execution results will be added after validation in Databricks.
