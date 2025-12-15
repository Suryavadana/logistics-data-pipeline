-- CREATE SHIPMENTS AND CUSTOMER TABLES.
CREATE TABLE raw_shipments(
	shipment_id INT,
    customer_id INT,
    ship_date VARCHAR(50),
    delivery_date VARCHAR(50),
    cost DECIMAL(10,2),
    status VARCHAR(50)
);
    
CREATE TABLE raw_customers (
    customer_id INT,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

-- IMPORT the data into the tables
-- NOW clean and standardize data
CREATE TABLE shipments AS
SELECT DISTINCT
    shipment_id,
    customer_id,

    CASE
        -- M/D/YYYY (e.g., 1/8/2024)
        WHEN ship_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(ship_date, '%m/%d/%Y')

        -- YYYY-MM-DD
        WHEN ship_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(ship_date, '%Y-%m-%d')

        -- YYYY/MM/DD
        WHEN ship_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
            THEN STR_TO_DATE(ship_date, '%Y/%m/%d')

        ELSE NULL
    END AS ship_date,

    CASE
        -- M/D/YYYY
        WHEN delivery_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(delivery_date, '%m/%d/%Y')

        -- YYYY-MM-DD
        WHEN delivery_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(delivery_date, '%Y-%m-%d')

        -- YYYY/MM/DD
        WHEN delivery_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
            THEN STR_TO_DATE(delivery_date, '%Y/%m/%d')

        ELSE NULL
    END AS delivery_date,

    COALESCE(cost, 0) AS cost,
    UPPER(status) AS status

FROM raw_shipments;

DROP TABLE IF EXISTS shipments;

CREATE TABLE customers AS
SELECT
    customer_id,
    customer_name,
    UPPER(region) AS region
FROM raw_customers;

-- No data is cleaned.
-- no duplicate shipment rows
-- uppercase status/region
-- missing cost replaced with 0

-- mysql data validation

-- check duplicate shipment_id
SELECT shipment_id, COUNT(*)
FROM shipments
GROUP BY shipment_id
HAVING COUNT(*) >1;

-- Check missing customer IDs
SELECT *
FROM shipments
WHERE customer_id IS NULL;

-- Total cost validation
SELECT SUM(cost) AS total_cost
FROM shipments;




