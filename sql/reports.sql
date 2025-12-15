
-- Shipments by customer
SELECT
    c.customer_name,
    COUNT(s.shipment_id) AS total_shipments,
    SUM(s.cost) AS total_cost
FROM shipments s
LEFT JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name;

-- Shipment status summary
SELECT
    status,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY status;

