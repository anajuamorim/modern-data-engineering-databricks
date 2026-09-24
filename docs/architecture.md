# Lakehouse Architecture

## Medallion Architecture

### Bronze
Raw and faithful representation of the source. It preserves what arrived and supports reprocessing and auditing.

### Silver
Cleaned and validated data. The exercise applies column selection, type correction, text standardization, deduplication and filtering.

### Gold
Business-ready analytical model.

The exercise creates a Star Schema with:

```text
                dim_produto
                     |
dim_cliente — fato_vendas — dim_loja
                     |
                 dim_tempo
```

The fact table represents sales events, while dimensions provide descriptive context.

## End-to-end flow

```text
CSV
 ↓
Volume
 ↓
Bronze Delta
 ↓
Silver Delta
 ↓
Gold Delta
 ↓
Star Schema
 ↓
Business Analytics
```

This architecture follows the FIAP/Databricks practical material used for the project.
