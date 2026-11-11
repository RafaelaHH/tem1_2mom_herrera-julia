-- Consulta 3.1
WITH resumen AS (
SELECT
region,
YEAR(order_date) AS anio,
SUM(sales) AS ventas,
SUM(profit) AS ganancias
FROM superstore
WHERE order_date IS NOT NULL
GROUP BY region, YEAR(order_date)
),
evolucion AS (
SELECT
region,
anio,
ventas,
ganancias,
LAG(ventas) OVER (
PARTITION BY region
ORDER BY anio
) AS ventas_anterior
FROM resumen
)
SELECT
region,
anio,
ROUND(ventas, 2) AS ventas,
ROUND(ganancias, 2) AS ganancias,
ROUND(
CASE WHEN ventas <> 0
THEN ganancias / ventas * 100
END, 2
) AS margen_pct,
ROUND(
CASE WHEN ventas_anterior <> 0
THEN (ventas - ventas_anterior)
/ ventas_anterior * 100
END, 2
) AS variacion_anual_pct
FROM evolucion
ORDER BY region, anio;
