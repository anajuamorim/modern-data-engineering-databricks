-- Gold layer — analytical Star Schema
-- Source: workspace.default.prata_vendas
--
-- Dimensions describe the business entities.
-- The fact table stores the sales event and its measures.

CREATE OR REPLACE TABLE workspace.default.dim_produto AS
SELECT DISTINCT
    sku,
    produto_nome,
    categoria,
    marca
FROM workspace.default.prata_vendas;

CREATE OR REPLACE TABLE workspace.default.dim_loja AS
SELECT DISTINCT
    id_loja,
    loja_nome,
    loja_cidade,
    loja_uf,
    loja_regiao
FROM workspace.default.prata_vendas;

CREATE OR REPLACE TABLE workspace.default.dim_cliente AS
SELECT DISTINCT
    id_cliente,
    cliente_faixa_etaria,
    cliente_cidade,
    cliente_segmento
FROM workspace.default.prata_vendas;

CREATE OR REPLACE TABLE workspace.default.dim_tempo AS
SELECT DISTINCT
    data,
    year(data) AS ano,
    quarter(data) AS trimestre,
    month(data) AS mes
FROM workspace.default.prata_vendas;

CREATE OR REPLACE TABLE workspace.default.fato_vendas AS
SELECT
    id_venda,
    data,
    sku,
    id_loja,
    id_cliente,
    quantidade,
    valor_unitario,
    desconto,
    valor_venda
FROM workspace.default.prata_vendas;

-- Example analytical query:
-- revenue by product category.

SELECT
    p.categoria,
    SUM(f.valor_venda) AS faturamento
FROM workspace.default.fato_vendas f
JOIN workspace.default.dim_produto p
    ON f.sku = p.sku
GROUP BY p.categoria
ORDER BY faturamento DESC;
