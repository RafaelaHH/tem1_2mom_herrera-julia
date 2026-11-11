-- Consulta 2.1
SELECT
COUNT(*) AS total_registros,
COUNT(DISTINCT order_id) AS ordenes_unicas,
COUNT(DISTINCT customer_id) AS clientes_unicos,
SUM(CASE WHEN sales <= 0 THEN 1 ELSE 0 END) AS ventas_no_positivas,
SUM(CASE WHEN discount < 0 OR discount > 1 THEN 1 ELSE 0 END) AS descuentos_invalidos,
SUM(CASE WHEN ship_date < order_date THEN 1 ELSE 0 END) AS envios_anteriores,
SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS fechas_nulas
FROM superstore;

-- Consulta 2.2
SELECT
row_id,
COUNT(*) AS repeticiones
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1
ORDER BY repeticiones DESC;

-- Consulta 2.3
SELECT
SUM(CASE WHEN row_id IS NULL THEN 1 ELSE 0 END) AS row_id_nulos,
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulos,
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulos,
SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_nulas,
SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS ship_date_nulas,
SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS sales_nulas,
SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulas,
SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS discount_nulos,
SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS profit_nulos
FROM superstore;

-- Consulta 2.4
SELECT
COUNT(*) AS total_fechas_invalidas
FROM superstore
WHERE order_date IS NULL
OR ship_date IS NULL
OR ship_date < order_date;

-- Consulta 2.5
SELECT
COUNT(*) AS total_registros,
SUM(CASE WHEN sales <= 0 THEN 1 ELSE 0 END) AS ventas_invalidas,
SUM(CASE WHEN discount < 0 OR discount > 1 THEN 1 ELSE 0 END) AS descuentos_invalidos
FROM superstore;
