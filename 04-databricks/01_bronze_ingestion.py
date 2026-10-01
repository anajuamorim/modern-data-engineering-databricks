# Bronze ingestion — Databricks / PySpark
#
# This notebook script follows the practical flow:
# CSV -> Spark DataFrame -> Bronze Delta table.
#
# Execution is intentionally kept separate from the repository documentation:
# results should be added after running the code in Databricks.

from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()

# 1. Source file stored in the Databricks Volume
caminho_csv = "/Volumes/workspace/default/aula_databricks/vendas.csv"

# 2. Read the raw CSV
df_csv = (
    spark.read
    .option("header", "true")
    .option("inferSchema", "true")
    .option("sep", ",")
    .csv(caminho_csv)
)

# 3. Inspect the source before creating the Bronze table
display(df_csv)

df_csv.printSchema()

print("Rows:", df_csv.count())
print("Columns:", len(df_csv.columns))
print("Column names:", df_csv.columns)

# 4. Persist the source as a Delta table
(
    df_csv.write
    .mode("overwrite")
    .saveAsTable("workspace.default.bronze_vendas")
)

# 5. Inspect Delta history
spark.sql(
    "DESCRIBE HISTORY workspace.default.bronze_vendas"
).show(truncate=False)
