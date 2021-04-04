-- Create database 'test' and show all the databases
CREATE DATABASE test;
SHOW DATABASES;

-- Create table 'books' in the database 'test'. It has the columns 'book_id', 'title' and 'status'.
CREATE TABLE test.books(
    book_id INT, -- Column 'book_id' is of type INT
    title TEXT, -- Column 'title' is of type TEXT
    status INT -- Column 'statu' is of type 'INT'
);

-- Show the tables of database 'test'
SHOW TABLES FROM test;

-- Specify the database ('test') that is going to be used in the next commands
USE test;

-- Now it is not necessary to use the 'From test' subcommand in the last one
SHOW TABLES;

-- Show the description of each column of the table (books)
DESCRIBE books;

-- Insert data in the table 'books'
INSERT INTO books VALUES(100, 'Heart of Darkness', 0);
INSERT INTO books VALUES(101, 'The Catcher of the Rye', 1);
INSERT INTO books VALUES(102, 'My Antonia', 0);

-- SELECT all columns and display them
SELECT * FROM books;

-- Filter the files by those values WHERE status = 1
SELECT * FROM books
WHERE status = 1;

-- The same than the last cell (change 1 by 0), but instead a semicolon is '\G' that shows the results as a batch of lines for each record
SELECT * FROM books
WHERE status = 0;

-- UPDATE the data in the table
UPDATE books SET status = 1 WHERE book_id = 102;
-- SHOW the table modified
SELECT * FROM books WHERE status = 1;

-- UPDATE and SHOW data in other cell
UPDATE books SET status = 0 WHERE book_id = 101;
SELECT * FROM books WHERE status = 0;

-- UPDATE more than two items at same statement
UPDATE books
SET title = 'The Catcher in the Rye', status = 1
WHERE book_id = 101;

-- CREATE other table and INSERT values
CREATE TABLE status_names(
    status_id INT,
    status_name CHAR(8)
);
INSERT INTO status_names VALUES(0, 'Inactive'), (1, 'Active');

-- SHOW the new table
SELECT * FROM status_names;

-- JOIN both tables and show specific columns filter by specific files
SELECT book_id, title, status_name
FROM books JOIN status_names
WHERE status = status_id;