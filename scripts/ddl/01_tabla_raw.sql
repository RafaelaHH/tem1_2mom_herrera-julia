CREATE DATABASE IF NOT EXISTS examen_superstore;
USE examen_superstore;

CREATE EXTERNAL TABLE IF NOT EXISTS superstore_raw (
    row_id STRING,
    order_id STRING,
    order_date STRING,
    ship_date STRING,
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
    sales STRING,
    quantity STRING,
    discount STRING,
    profit STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/superstore_raw';
