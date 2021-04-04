-- CREATE the database
CREATE DATABASE rookery;

-- DROP (Delete) table
DROP DATABASE rookery;
-- CREATE again the database
CREATE DATABASE rookery -- Database created
CHARACTER SET latin1 -- Default characters used in database's table are 'Latin letters'
COLLATE latin1_bin; -- Default method of sorting is based on binary 'Latin characters'

-- SHOW the database
SHOW DATABASES;

-- Set the database as default
USE rockery;

-- CREATE a table in the new database
CREATE TABLE birds(
    bird_id INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY is the unique statement which define the file in the table and database
    scientific_name VARCHAR(255) UNIQUE, -- UNIQUE means that there are not equal values in the column
    common_name VARCHAR(50), 
    family_id INT,
    description TEXT
);

-- Show the characteristics of the table
DESCRIBE birds;

-- Insert various values in specific columns of the table
INSERT INTO birds (scientific_name, common_name)
VALUES ('Charadrius vociferus', 'Killdeer'),
('Gavia immer', 'Great Northern Loon'),
('Aix sponsa', 'Wood Duck'),
('Chordeiles minor', 'Common Nighthawk'),
('Sitta carolinensis', ' White-breasted Nuthatch'),
('Apteryx mantelli', 'North Island Brown Kiwi');

-- Show all columns and values in table birds
SELECT * FROM birds;

-- CREATE another database and a table in it
CREATE DATABASE birdwatchers;
CREATE TABLE birdwatchers.humans(
    human_id INT AUTO_INCREMENT PRIMARY KEY, -- AUTO_INCREMENT does a default value in the column based in the last value
    formal_title VARCHAR(25),
    name_first VARCHAR(25),
    name_last VARCHAR(25),
    email_address VARCHAR(255)
);

-- Add values in the table 
INSERT INTO birdwatchers.humans (formal_title, name_first, name_last, email_address)
VALUES('Mr.', 'Russell', 'Dyer', 'russell@mysqlresources.com'),
('Mr.', 'Richard', 'Stringer', 'richard@mysqlresources.com'),
('Ms.', 'Rusty', 'Osborne', 'rusty@mysqlresources.com'),
('Ms.', 'Lexi', 'Hollar', 'alexandra@mysqlresources.com');

-- The 'SHOW CREATE TABLE' let you know de description of the columns in table
USE rockery;
SHOW CREATE TABLE birds;

-- Do other table with extra information (family) related to the birds and can be equal depending on the birds
CREATE TABLE bird_families (
    family_id INT AUTO_INCREMENT PRIMARY KEY,
    scientific_name VARCHAR(255) UNIQUE,
    brief_description VARCHAR(255) 
);

-- Create a table with an specific encoding, that is better than latin1
CREATE TABLE bird_orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    scientific_name VARCHAR(255) UNIQUE,
    brief_description VARCHAR(255),
    order_image BLOB
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci; -- Do the default encoding as UTF-8. It is greater than latin1

SELECT * FROM birdwatchers.humans;