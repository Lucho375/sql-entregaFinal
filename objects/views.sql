USE workshop;

CREATE VIEW customer_vehicle_info AS
SELECT
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    v.id AS vehicle_id,
    v.brand,
    v.model
FROM
    customer c
    JOIN vehicle v ON c.id = v.customer_id;

CREATE VIEW billing_details AS
SELECT
    i.id AS invoice_id,
    i.total,
    COALESCE(SUM(p.paid_amount), 0) AS total_paid
FROM
    invoice i
    LEFT JOIN payment p ON i.id = p.invoice_id
GROUP BY
    i.id,
    i.total;

CREATE VIEW work_order_summary AS
SELECT
    wo.id AS work_order_id,
    v.brand,
    v.model,
    m.name AS mechanic_name,
    wo.problem_description
FROM
    work_order wo
    JOIN mechanic m ON wo.mechanic_id = m.id
    JOIN vehicle v ON wo.vehicle_id = v.id;