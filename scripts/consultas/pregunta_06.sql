-- Consulta 6.1
WITH clasificacion AS (
SELECT
category,
sub_category,
sales,
profit,
discount,
CASE
WHEN discount = 0
THEN 'Sin descuento'
WHEN discount > 0 AND discount <= 0.20
THEN 'Bajo'
WHEN discount > 0.20 AND discount <= 0.50
THEN 'Medio'
WHEN discount > 0.50
THEN 'Alto'
ELSE 'Invalido'
END AS rango
FROM superstore
)
SELECT
rango,
COUNT(*) AS registros,
ROUND(SUM(sales), 2) AS ventas,
ROUND(SUM(profit), 2) AS ganancias,
ROUND(
CASE WHEN SUM(sales) <> 0
THEN SUM(profit) / SUM(sales) * 100
END, 2
) AS margen_pct,
SUM(
CASE WHEN profit < 0 THEN 1 ELSE 0 END
) AS registros_perdida,
ROUND(
100.0 * SUM(
CASE WHEN profit <= 0 THEN 1 ELSE 0 END
) / COUNT(*), 2
) AS no_rentables_pct,
ROUND(AVG(discount) * 100, 2)
AS descuento_promedio_pct
FROM clasificacion
GROUP BY rango
ORDER BY rango;
