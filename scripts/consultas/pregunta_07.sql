-- Consulta 7.1
WITH mensual AS (
SELECT
YEAR(order_date) AS anio,
MONTH(order_date) AS mes,
SUM(sales) AS ventas,
SUM(profit) AS ganancias
FROM superstore
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
),
comparacion AS (
SELECT
*,
LAG(ventas, 1) OVER (
ORDER BY anio, mes
) AS ventas_mes_anterior,
LAG(ventas, 12) OVER (
ORDER BY anio, mes
) AS ventas_anio_anterior,
AVG(ventas) OVER (
ORDER BY anio, mes
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
) AS promedio_movil
FROM mensual
)
SELECT
anio,
mes,
ROUND(ventas, 2) AS ventas,
ROUND(ganancias, 2) AS ganancias,
ROUND(
CASE WHEN ventas_mes_anterior <> 0
THEN (ventas - ventas_mes_anterior)
/ ventas_mes_anterior * 100
END, 2
) AS variacion_mensual_pct,
ROUND(
CASE WHEN ventas_anio_anterior <> 0
THEN (ventas - ventas_anio_anterior)
/ ventas_anio_anterior * 100
END, 2
) AS variacion_anual_pct,
ROUND(promedio_movil, 2) AS promedio_movil_3m
FROM comparacion
ORDER BY anio, mes;

-- Consulta 7.2
WITH mensual AS (SELECT YEAR(order_date) AS anio,MONTH(order_date) AS mes,SUM(sales) AS ventas FROM superstore GROUP BY YEAR(order_date),MONTH(order_date)) SELECT * FROM mensual ORDER BY ventas DESC LIMIT 3;

-- Consulta 7.3
WITH mensual AS (SELECT YEAR(order_date) AS anio,MONTH(order_date) AS mes,SUM(sales) AS ventas FROM superstore GROUP BY YEAR(order_date),MONTH(order_date)) SELECT * FROM mensual ORDER BY ventas ASC LIMIT 3;
