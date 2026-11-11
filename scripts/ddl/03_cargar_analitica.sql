USE examen_superstore;
INSERT OVERWRITE TABLE superstore
SELECT
    CAST(row_id AS INT),
    order_id,
    CAST(FROM_UNIXTIME(UNIX_TIMESTAMP(order_date, 'M/d/yyyy'), 'yyyy-MM-dd') AS DATE),
    CAST(FROM_UNIXTIME(UNIX_TIMESTAMP(ship_date, 'M/d/yyyy'), 'yyyy-MM-dd') AS DATE),
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    CAST(sales AS DECIMAL(18,4)),
    CAST(quantity AS INT),
    CAST(discount AS DECIMAL(8,4)),
    CAST(profit AS DECIMAL(18,4))
FROM superstore_raw;

SELECT COUNT(*) AS registros FROM superstore;
