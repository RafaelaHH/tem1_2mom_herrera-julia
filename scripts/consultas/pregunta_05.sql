-- Consulta 5.1
WITH productos AS (
SELECT
category,
product_id,
MAX(product_name) AS producto,
SUM(sales) AS ventas,
SUM(profit) AS ganancias
FROM superstore
GROUP BY category, product_id
),
ranking AS (
SELECT
*,
RANK() OVER (
PARTITION BY category
ORDER BY ganancias DESC
) AS posicion
FROM productos
)
SELECT
category,
producto,
ROUND(ventas, 2) AS ventas,
ROUND(ganancias, 2) AS ganancias,
ROUND(
ganancias / NULLIF(ventas, 0) * 100, 2
) AS margen_pct,
posicion
FROM ranking
WHERE posicion <= 5
ORDER BY category, posicion;

-- Consulta 5.2
SELECT
product_id,
MAX(product_name) AS producto,
SUM(quantity) AS unidades_vendidas,
ROUND(SUM(sales), 2) AS ventas_totales
FROM superstore
GROUP BY product_id
ORDER BY unidades_vendidas DESC
LIMIT 5;

-- Consulta 5.3
SELECT
product_id,
MAX(product_name) AS producto,
ROUND(SUM(sales), 2) AS ventas,
ROUND(SUM(profit), 2) AS ganancias,
ROUND(
SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2
) AS margen_pct
FROM superstore
GROUP BY product_id
ORDER BY ganancias ASC
LIMIT 5;

-- Consulta 5.4
WITH productos AS (
SELECT
category,
product_id,
MAX(product_name) AS producto,
SUM(sales) AS ventas,
SUM(profit) AS ganancias
FROM superstore
GROUP BY category, product_id
)
SELECT
category,
producto,
ROUND(ventas, 2) AS ventas,
ROUND(ganancias, 2) AS ganancias,
ROUND(
ganancias / NULLIF(ventas, 0) * 100, 2
) AS margen_pct,
RANK() OVER (
PARTITION BY category
ORDER BY ganancias DESC
) AS ranking,
DENSE_RANK() OVER (
PARTITION BY category
ORDER BY ganancias DESC
) AS ranking_denso,
ROUND(
SUM(ganancias) OVER (
PARTITION BY category
ORDER BY ganancias DESC, product_id
ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW
), 2
) AS ganancia_acumulada
FROM productos
ORDER BY category, ranking, producto;
