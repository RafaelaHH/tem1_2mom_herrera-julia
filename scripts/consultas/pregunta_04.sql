-- Consulta 4.1
WITH referencia AS (
SELECT MAX(order_date) AS fecha_maxima
FROM superstore
),
rfm AS (
SELECT
s.customer_id,
DATEDIFF(
MAX(r.fecha_maxima),
MAX(s.order_date)
) AS recency,
COUNT(DISTINCT s.order_id) AS frequency,
SUM(s.sales) AS monetary
FROM superstore s
CROSS JOIN referencia r
WHERE s.customer_id IS NOT NULL
AND s.order_date IS NOT NULL
GROUP BY s.customer_id
),
puntuacion AS (
SELECT
*,
NTILE(5) OVER (
ORDER BY recency DESC
) AS r_score,
NTILE(5) OVER (
ORDER BY frequency ASC
) AS f_score,
NTILE(5) OVER (
ORDER BY monetary ASC
) AS m_score
FROM rfm
)
SELECT
customer_id,
recency,
frequency,
ROUND(monetary, 2) AS monetary,
r_score,
f_score,
m_score,
CASE
WHEN r_score >= 4
AND f_score >= 4
AND m_score >= 4
THEN 'Alto valor'
WHEN f_score >= 4
THEN 'Recurrente'
WHEN r_score <= 2
THEN 'En riesgo'
ELSE 'Regular'
END AS segmento
FROM puntuacion
ORDER BY monetary DESC;
