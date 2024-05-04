USE workshop;

DELIMITER / / CREATE FUNCTION getFullName(first_name VARCHAR(50), last_name VARCHAR(50)) RETURNS VARCHAR(100) DETERMINISTIC BEGIN DECLARE fullname VARCHAR(100);

SET
	fullname = CONCAT(first_name, ' ', last_name);

RETURN fullname;

END / / CREATE FUNCTION calculateTotalInvoice(p_work_order_id INT) RETURNS DECIMAL(10, 2) DETERMINISTIC BEGIN DECLARE total_invoice DECIMAL(10, 2);

SELECT
	SUM(total) INTO total_invoice
FROM
	invoice
WHERE
	work_order_id = p_work_order_id;

RETURN total_invoice;

END / / DELIMITER;