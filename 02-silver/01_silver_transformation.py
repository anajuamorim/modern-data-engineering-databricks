# Silver transformation — Databricks / PySpark
#
# Bronze -> Silver:
# select business columns, standardize types, normalize text,
# remove duplicate sales and keep valid sale values.

from pyspark.sql import functions as F

df_prata = (
    spark.table("workspace.default.bronze_vendas")
    .select(
        "id_venda",
        "data",
        "sku",
        "produto_nome",
        "categoria",
        "marca",
        "id_loja",
        "loja_nome",
        "loja_cidade",
        "loja_uf",
        "loja_regiao",
        "id_cliente",
        "cliente_faixa_etaria",
        "cliente_cidade",
        "cliente_segmento",
        "quantidade",
        "valor_unitario",
        "desconto",
        "valor_venda",
    )
    .withColumn("data", F.to_date("data"))
    .withColumn("loja_uf", F.upper(F.trim("loja_uf")))
    .withColumn(
        "valor_venda",
        F.col("valor_venda").cast("decimal(12,2)")
    )
    .dropDuplicates(["id_venda"])
    .filter(F.col("valor_venda") > 0)
)

display(df_prata)

(
    df_prata.write
    .mode("overwrite")
    .saveAsTable("workspace.default.prata_vendas")
)

# Basic inspection after the transformation.
print("Silver rows:", df_prata.count())
print("Silver columns:", len(df_prata.columns))
