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
	
	
-- #1 Insert data into owners table

INSERT INTO owners (first_name, last_name, city, state, email)
VALUES ('Samuel','Smith','Boston','MA','samsmith@gmail.com'),('Emma','Johnson','Seattle','WA','emmajohnson@gmail.com'),
('John','Oliver','New York','NY','johnoliver@gmail.com'),('Olivia','Brown','San Francisco','CA','olivabrown@gmail.com'),
('Simon','Smith','Dallas','TX','sismith@gmail.com'),(null,'Maxwell',null,'CA','lordmaxwell@gmail.com');

SELECT * FROM owners;

-- carefull this deletes the records but the index keeps going from the last used index - had to DROP TABLE owners CASCADE the CREATE again
DELETE FROM owners;

-- #2 Insert data into pers table

INSERT INTO pets (species, full_name, age, owner_id)
VALUES ('Dog','Rex',6,1),('Rabbit','Fluffy',2,5),('Cat','Tom',8,2),
('Mouse','Jerry',2,2),('Dog','Biggles',4,1),('Tortoise','Squirtle',42,3);


SELECT * FROM pets;

-- #3 Update Fluffy the rabbits age to 3
-- be careful to use WHERE to change only the item you want not all items

UPDATE pets
SET age = 3
WHERE id = 8;



-- #4 Delete Mr Maxwell from the owners table

DELETE FROM owners
WHERE id = 6;

SELECT * FROM owners;

 
