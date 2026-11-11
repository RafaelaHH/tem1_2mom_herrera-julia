-- Consulta 8.1
WITH productos AS (
SELECT
product_id,
MAX(product_name) AS producto,
SUM(sales) AS valor
FROM superstore
GROUP BY product_id
),
acumulado AS (
SELECT
*,
SUM(valor) OVER (
ORDER BY valor DESC, product_id
ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW
) AS valor_acumulado,
SUM(valor) OVER () AS total
FROM productos
),
porcentajes AS (
SELECT
*,
100.0 * valor / total AS participacion,
100.0 * valor_acumulado / total
AS porcentaje_acumulado,
ROW_NUMBER() OVER (
ORDER BY valor DESC, product_id
) AS posicion
FROM acumulado
WHERE total > 0
)
SELECT
producto,
ROUND(valor, 2) AS ventas,
ROUND(participacion, 2) AS participacion_pct,
ROUND(porcentaje_acumulado, 2)
AS acumulado_pct,
posicion
FROM porcentajes
ORDER BY posicion;

-- Consulta 8.2
WITH productos AS (
SELECT
product_id,
MAX(product_name) AS producto,
SUM(profit) AS valor
FROM superstore
GROUP BY product_id
),
acumulado AS (
SELECT
*,
SUM(valor) OVER (
ORDER BY valor DESC, product_id
ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW
) AS valor_acumulado,
SUM(valor) OVER () AS total
FROM productos
),
porcentajes AS (
SELECT
*,
100.0 * valor / total AS participacion,
100.0 * valor_acumulado / total
AS porcentaje_acumulado,
ROW_NUMBER() OVER (
ORDER BY valor DESC, product_id
) AS posicion
FROM acumulado
WHERE total > 0
)
SELECT
producto,
ROUND(valor, 2) AS ganancias,
ROUND(participacion, 2) AS participacion_pct,
ROUND(porcentaje_acumulado, 2)
AS acumulado_pct,
posicion
FROM porcentajes
ORDER BY posicion;
