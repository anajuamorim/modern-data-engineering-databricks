-- Business analysis queries
-- Execute after the Gold layer has been created.
-- Results must be recorded only after actual execution.

-- 1. Revenue by region and quarter.
SELECT
    l.loja_regiao,
    t.ano,
    t.trimestre,
    SUM(f.valor_venda) AS faturamento
FROM workspace.default.fato_vendas f
JOIN workspace.default.dim_loja l
    ON f.id_loja = l.id_loja
JOIN workspace.default.dim_tempo t
    ON f.data = t.data
GROUP BY
    l.loja_regiao,
    t.ano,
    t.trimestre
ORDER BY
    t.ano,
    t.trimestre,
    faturamento DESC;

-- 2. Top 10 products by revenue.
SELECT
    p.sku,
    p.produto_nome,
    SUM(f.valor_venda) AS faturamento
FROM workspace.default.fato_vendas f
JOIN workspace.default.dim_produto p
    ON f.sku = p.sku
GROUP BY
    p.sku,
    p.produto_nome
ORDER BY faturamento DESC
LIMIT 10;

-- 3. Top 10 brands by revenue.
SELECT
    p.marca,
    SUM(f.valor_venda) AS faturamento
FROM workspace.default.fato_vendas f
JOIN workspace.default.dim_produto p
    ON f.sku = p.sku
GROUP BY p.marca
ORDER BY faturamento DESC
LIMIT 10;

-- 4. Average ticket by customer segment.
SELECT
    c.cliente_segmento,
    AVG(f.valor_venda) AS ticket_medio
FROM workspace.default.fato_vendas f
JOIN workspace.default.dim_cliente c
    ON f.id_cliente = c.id_cliente
GROUP BY c.cliente_segmento
ORDER BY ticket_medio DESC;

-- 5. Example of a metric that should NOT be used as revenue:
-- SUM(valor_unitario)
--
-- Unit price describes the price of one unit.
-- Revenue should use the sale value represented by valor_venda.
