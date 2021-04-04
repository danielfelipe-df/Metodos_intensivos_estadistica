-- Create API user accounts

CREATE USER 'public_api'@'localhost'
IDENTIFIED BY 'pwd_123';

GRANT SELECT
ON rookery.*
TO 'public_api'@'localhost';

GRANT SELECT
ON birdwatchers.*
TO 'public_api'@'localhost';

CREATE USER 'admin_members'@'localhost'
IDENTIFIED BY 'doc_killdeer_123';

GRANT SELECT, UPDATE, DELETE
ON birdwatchers.*
TO 'admin_members'@'localhost';

SELECT common_name, scientific_name FROM birds
WHERE common_name LIKE '%';
GRANT ALL PRIVILEGES ON *.* TO 'bad_guy'@'%';
