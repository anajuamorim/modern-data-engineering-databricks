# 03 — Gold Layer

The Gold layer creates the analytical Star Schema used for business queries.

## Dimensions

- `dim_produto`
- `dim_loja`
- `dim_cliente`
- `dim_tempo`

## Fact

- `fato_vendas`

## Dimensions

```sql
CREATE OR REPLACE TABLE dim_produto AS
SELECT DISTINCT sku, produto_nome, categoria, marca
FROM prata_vendas;

CREATE OR REPLACE TABLE dim_loja AS
SELECT DISTINCT id_loja, loja_nome, loja_cidade, loja_uf, loja_regiao
FROM prata_vendas;

CREATE OR REPLACE TABLE dim_cliente AS
SELECT DISTINCT id_cliente, cliente_faixa_etaria, cliente_cidade, cliente_segmento
FROM prata_vendas;

CREATE OR REPLACE TABLE dim_tempo AS
SELECT DISTINCT
    data,
    year(data) AS ano,
    quarter(data) AS trimestre,
    month(data) AS mes
FROM prata_vendas;
```

## Fact

```sql
CREATE OR REPLACE TABLE fato_vendas AS
SELECT
    id_venda, data, sku, id_loja, id_cliente,
    quantidade, valor_unitario, desconto, valor_venda
FROM prata_vendas;
```

## Business query

```sql
SELECT
    p.categoria,
    SUM(f.valor_venda) AS faturamento
FROM fato_vendas f
JOIN dim_produto p ON f.sku = p.sku
GROUP BY p.categoria
ORDER BY faturamento DESC;
```

> Results will be recorded only after execution and validation.
