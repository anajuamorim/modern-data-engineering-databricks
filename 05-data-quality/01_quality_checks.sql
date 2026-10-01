-- Data quality checks
-- These queries are intended to be executed in Databricks.
-- They document validations without inventing execution results.

-- 1. Check row counts.
SELECT COUNT(*) AS total_rows
FROM workspace.default.prata_vendas;

SELECT COUNT(*) AS total_rows
FROM workspace.default.fato_vendas;

-- 2. Check duplicated sale identifiers.
SELECT
    id_venda,
    COUNT(*) AS occurrences
FROM workspace.default.fato_vendas
GROUP BY id_venda
HAVING COUNT(*) > 1;

-- 3. Check invalid revenue values.
SELECT COUNT(*) AS invalid_revenue_rows
FROM workspace.default.fato_vendas
WHERE valor_venda <= 0;

-- 4. Check fact/dimension referential integrity.
SELECT COUNT(*) AS orphan_products
FROM workspace.default.fato_vendas f
LEFT JOIN workspace.default.dim_produto p
    ON f.sku = p.sku
WHERE p.sku IS NULL;

SELECT COUNT(*) AS orphan_stores
FROM workspace.default.fato_vendas f
LEFT JOIN workspace.default.dim_loja l
    ON f.id_loja = l.id_loja
WHERE l.id_loja IS NULL;

SELECT COUNT(*) AS orphan_customers
FROM workspace.default.fato_vendas f
LEFT JOIN workspace.default.dim_cliente c
    ON f.id_cliente = c.id_cliente
WHERE c.id_cliente IS NULL;

-- 5. Inspect Delta history.
DESCRIBE HISTORY workspace.default.fato_vendas;

-- Expected use:
-- run the checks, record the observed results, and only then
-- add those results to the project documentation.
