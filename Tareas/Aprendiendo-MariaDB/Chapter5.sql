-- Change one of the default values or set one of the options. It is done with ALTER
ALTER TABLE bird_families
ADD COLUMN order_id INT;

-- To create a copy of a table we use the command LIKE
CREATE TABLE test.birds_new LIKE birds;

-- Set 'test' as the default database and show the description of birds_new table
USE test;
DESCRIBE birds_new;

-- When we did the copy, we just copied the structure, not the data. We can do it with SELECT
INSERT INTO birds_new
SELECT * FROM rookery.birds;

-- The next method is to do the copy of data. The structure is not copy. There is missing AUTO_INCREMENT and PRIMARY_KEY
CREATE TABLE birds_new_alternative
SELECT * FROM rookery.birds;

-- Delete the last table
DROP TABLE birds_new_alternative;

-- Add a new column to the table
ALTER TABLE birds_new
ADD COLUMN wing_id CHAR(2);

-- Show the description of the table
DESCRIBE birds_new;

-- Delete the column because is at the end of the table, but we need it in other place
ALTER TABLE birds_new
DROP COLUMN wing_id;

-- Add the new column after family_id. If need to put it on the first column, change AFTER to FIRST
ALTER TABLE birds_new
ADD COLUMN wing_id CHAR(2) AFTER family_id;

-- Add differente columns in the position needed. And change the width of a column
ALTER TABLE birds_new
ADD COLUMN body_id CHAR(2) AFTER wing_id,
ADD COLUMN bill_id CHAR(2) AFTER body_id,
ADD COLUMN endangered BIT DEFAULT b'1' AFTER bill_id, -- The BIT type is boolean (0 or 1)
CHANGE COLUMN common_name common_name VARCHAR(255);

-- Modify a column values of specific lines
UPDATE birds_new SET endangered = 0
WHERE bird_id IN(1,2,4,5);

-- Display specific columns of the table filtered by an specific value in a column
SELECT bird_id, scientific_name, common_name
FROM birds_new
WHERE endangered; -- It is equal to WHERE endangered = 1

-- Display all the columns, but where endangered = 0
SELECT * FROM birds_new
WHERE NOT endangered;

-- Because are several degrees of endangered, so we can modify the type of values by ENUM via MODIFY COLUMN
ALTER TABLE birds_new
MODIFY COLUMN endangered
ENUM('Extinct',
    'Extinct in Wild',
    'Threatened - Critically Endangered',
    'Threatened - Endangered',
    'Threatened - Vulnerable',
    'Lower Risk - Conservation Dependent',
    'Lower Risk - Near Threatened',
    'Lower Risk - Least Concern')
AFTER family_id;

-- Show the description of the specific column
SHOW COLUMNS FROM birds_new LIKE 'endangered';

-- Set all the values of the ENUM column of an specific value. If we know the order it is easy
UPDATE birds_new
SET endangered = 7;

-- USE other database and create tables
USE birdwatchers;

CREATE TABLE surveys(
    survey_id INT AUTO_INCREMENT KEY,
    survey_name VARCHAR(255)
);

CREATE TABLE survey_questions(
    question_id INT AUTO_INCREMENT KEY,
    survey_id INT,
    question VARCHAR(255),
    choices BLOB -- BLOB is a generic type, and we can use it to store a dynamic column
);

CREATE TABLE survey_answers(
    answer_id INT AUTO_INCREMENT KEY,
    human_id INT,
    question_id INT,
    date_answered DATETIME,
    answer VARCHAR(255)
);

-- Put some data in the tables
INSERT INTO surveys (survey_name)
VALUES("Favorite Birding Location");

INSERT INTO survey_questions (survey_id, question, choices)
VALUES(LAST_INSERT_ID(),
    "What's your favorite setting for bird-watching?",
    COLUMN_CREATE('1', 'forest', '2', 'shore', '3', 'backyard') -- This works to create an enumerate with specific key and value 1 -> forest, 2 -> shore, 3 -> backyard
);

INSERT INTO surveys (survey_name)
VALUES("Preferred Birds");

INSERT INTO survey_questions (survey_id, question, choices)
VALUES(LAST_INSERT_ID(),
    "Which type of birds do you like best?",
    COLUMN_CREATE('1', 'perching', '2', 'shore', '3', 'fowl', '4', 'rapture') 
);

-- Show the data in an specific format
SELECT COLUMN_GET(choices, 3 AS CHAR) AS 'Location' -- COLUMN_GET select the column (first argument) the key to be selected (3) and the type to be expressed
FROM survey_questions
WHERE survey_id = 1;

-- INSERT values into the table
INSERT INTO survey_answers (human_id, question_id, date_answered, answer)
VALUES (29, 1, NOW(), 2), -- NOW() is the DATETIME format for the now time
(29, 2, NOW(), 2),
(35, 1, NOW(), 1),
(35, 2, NOW(), 1),
(26, 1, NOW(), 2),
(26, 2, NOW(), 1),
(27, 1, NOW(), 2),
(27, 2, NOW(), 4),
(16, 1, NOW(), 3),
(3, 1, NOW(), 1),
(3, 2, NOW(), 1);

-- Count the votes for the first survey
SELECT IFNULL(COLUMN_GET(choices, answer AS CHAR), 'total') AS 'Birding Site', COUNT(*) AS 'Votes'
FROM survey_answers
JOIN survey_questions USING(question_id)
WHERE survey_id = 1 AND question_id = 1
GROUP BY answer WITH ROLLUP;

-- CREATE a table for the conservation_stattus
CREATE TABLE rookery.conservation_status(
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    conservation_category CHAR(10),
    conservation_state CHAR(25)
);

-- Add the values for the categories and states
INSERT INTO rookery.conservation_status (conservation_category, conservation_state)
VALUES('Extinct','Extinct'),
('Extinct','Extinct in Wild'),
('Threatened','Critically Endangered'),
('Threatened','Endangered'),
('Threatened','Vulnerable'),
('Lower Risk','Conservation Dependent'),
('Lower Risk','Near Threatened'),
('Lower Risk','Least Concern');

-- SHOW the table
SELECT * FROM rookery.conservation_status;

-- Alter the table and change to name to connect later to the new table created
USE test
ALTER TABLE birds_new
CHANGE COLUMN endangered conservation_status_id INT DEFAULT 8;

-- Change the default value
ALTER TABLE birds_new
ALTER conservation_status_id SET DEFAULT 7;

-- Delete the default value.
ALTER TABLE birds_new
ALTER conservation_status_id DROP DEFAULT;

-- SHOW the column auto_increment by a filter
SELECT auto_increment
FROM information_schema.tables
WHERE table_name = 'birds';

-- Return to the database rookery and modify the deafult value of the next add to 10 
USE rookery;
ALTER TABLE birds
AUTO_INCREMENT = 10;

-- Create an empty column
CREATE TABLE birds_new LIKE birds;

-- See the description of each table, and show the copy is empty
DESCRIBE birds;
DESCRIBE birds_new;
SELECT * FROM birds_new;

-- Show the description of a table
SHOW CREATE TABLE birds;

-- Modify the next value of the value will add
ALTER TABLE birds_new
AUTO_INCREMENT = 6;

-- Create the table as a copy of some columns of other tables
CREATE TABLE birds_details
SELECT bird_id, description
FROM birds;

-- Get the description
DESCRIBE birds_details;

-- Delete a column
ALTER TABLE birds
DROP COLUMN description;

-- Rename some columns
RENAME TABLE rookery.birds TO rookery.birds_old,
test.birds_new TO rookery.birds;

-- Show the tables in all databases starting with 'birds'
SHOW TABLES IN rookery LIKE 'birds%';

