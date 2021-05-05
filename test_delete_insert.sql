-- Database: test

-- DROP DATABASE test;

CREATE DATABASE test
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	
	
-- Insert data into a table

/*

INSERT INTO tablename (columname1, columname2, columnname3)
VALUES ('value1', 'value2', 'value3');


*/


INSERT INTO examples (first_name, last_name, email, nationality, age)
VALUES ('David', 'Mitchell', 'dmitchell@gmail.com', 'GBR', 43);


INSERT INTO examples (first_name, last_name, email, nationality, age)
VALUES ()


INSERT INTO examples (first_name, last_name, email, nationality, age)
VALUES ('Emily', 'Watson','ewatson@gmail.com','USA',29),('Theo','Scott','tscott@gmail.com','AUS',33),
('Emily','Smith','esmith@gmail.com','GBR',29), ('Jim','Burr','jburr@gmail.com','USA',54);




SELECT * FROM examples

-- UPDATE DATA IN A TABLE

/*
UPDATE tablename
SET columnname = 'newvalue'
WHERE columnname = 'value';

*/

-- be careful to use WHERE to change only the item you want not all items

UPDATE examples
SET email = 'davidmitchell@gmailcom'
WHERE example_id = 1;

UPDATE examples
SET nationality = 'CAN'
WHERE nationality = 'USA';

UPDATE examples
SET first_name = 'James', age = 55
WHERE example_id = 5;


-- Deleting data from a table

/*
DELETE FROM tablename
WHERE columname = 'value';

*/

DELETE FROM examples
WHERE example_id = 2;

SELECT * FROM examples

DELETE FROM examples
WHERE nationality = 'GBR';


-- to delete all rows

DELETE FROM examples;











































