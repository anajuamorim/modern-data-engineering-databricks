# 05 — Data Quality

Data quality checks validate transformations between layers.

## Silver checks

Validate that:

- `id_venda` is unique after deduplication
- `data` has the expected date type
- `loja_uf` is standardized
- `valor_venda` has the expected decimal type
- `valor_venda > 0`

## Gold checks

Validate:

- dimension uniqueness
- relationships between fact and dimensions
- consistency between Silver and Fact totals

## Delta history

```sql
DESCRIBE HISTORY fato_vendas;
```

The practical material also introduces Time Travel with `VERSION AS OF` and restoration with `RESTORE TABLE`.

> Validation results will be added after Databricks execution.
