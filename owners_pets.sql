-- Database: owners_pets

-- DROP DATABASE owners_pets;

CREATE DATABASE owners_pets
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- Challenge
-- 1 create new database owners_pets

-- 2 create the owners table
	
	CREATE TABLE owners(
	
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	city VARCHAR(30),
	state CHAR(2)
	); 
	
	SELECT * FROM owners;
	
-- 3 create pets table with a foreign key

	CREATE TABLE pets(

		id SERIAL PRIMARY KEY,
		species VARCHAR(30),
		full_name VARCHAR(30),
		age INT,
		owner_id INT REFERENCES owners (id)
	);
	
	
SELECT * FROM pets

--4 add email column to owners table


	ALTER TABLE owners
	ADD COLUMN email VARCHAR(50) UNIQUE;


-- 5 change data type of last_name to VARCHAR(50)

ALTER TABLE owners
ALTER COLUMN last_name TYPE VARCHAR(50);
	
	