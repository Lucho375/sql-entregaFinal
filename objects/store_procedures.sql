USE workshop;

DELIMITER / / CREATE PROCEDURE CreateUser(
	IN p_username VARCHAR(16),
	IN p_email VARCHAR(255),
	IN p_password VARCHAR(32),
	IN p_role VARCHAR(45)
) BEGIN
INSERT INTO
	`user` (username, email, password, role)
VALUES
	(
		p_username,
		p_email,
		p_password,
		p_role
	);

END / / DELIMITER;