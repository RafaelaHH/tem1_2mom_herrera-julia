USE examen_superstore;
CREATE TABLE IF NOT EXISTS superstore (
    row_id INT,
    order_id STRING,
    order_date DATE,
    ship_date DATE,
    ship_mode STRING,
    customer_id STRING,
    customer_name STRING,
    segment STRING,
    country STRING,
    city STRING,
    state STRING,
    postal_code STRING,
    region STRING,
    product_id STRING,
    category STRING,
    sub_category STRING,
    product_name STRING,
    sales DECIMAL(18,4),
    quantity INT,
    discount DECIMAL(8,4),
    profit DECIMAL(18,4)
) STORED AS ORC;
