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
	
-- modify table and add a column

CREATE TABLE examples (

	example_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30)
	
);

SELECT * FROM examples;
	
-- here we add a column and a constraint of unique

	ALTER TABLE examples
	ADD COLUMN email VARCHAR(50) UNIQUE;

-- here we add two columns 
	
	ALTER TABLE examples
	ADD COLUMN nationality VARCHAR(30),
	ADD COLUMN age INT NOT NULL;
	
-- modify a columns data type
/*
ALTER TABLE tablename
ALTER COLUMN columnname TYPE new_data_type
*/

ALTER TABLE examples
ALTER COLUMN nationality TYPE CHAR(3);


ALTER TABLE examples
ALTER COLUMN last_name TYPE VARCHAR(50),
ALTER COLUMN email TYPE VARCHAR(80);
	
-- deleting tables from a database

CREATE TABLE practice (

	id SERIAL PRIMARY KEY,
	product_name VARCHAR(50),
	product_price NUMERIC(4,2)
);
	
	
SELECT * FROM practice;
	
	
DROP TABLE practice;



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	