USE workshop;

DELIMITER / / CREATE TRIGGER USER_BD BEFORE DELETE ON workshop.user FOR EACH ROW BEGIN
UPDATE
	workshop.user
SET
	enabled = 0
WHERE
	id = OLD.id;

END;

/ / DELIMITER;

DROP TRIGGER USER_BD;

SHOW TRIGGERS;

SELECT
	*
FROM
	user
WHERE
	user.id < 3
limit
	5;

DELETE FROM
	user
WHERE
	id = 1;

UPDATE
	workshop.user
SET
	enabled = TRUE
WHERE
	id = 1;