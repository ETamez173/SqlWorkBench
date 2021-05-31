

-- Using Casting to apply String Functions to Non String Data Types

/*
SELECT column_name::DATATYPE FROM table_name;
*/

SELECT date_of_birth FROM directors;
-- we get a date type and cant use string functions
SELECT date_of_birth::TEXT FROM directors;
-- now we can cast then apply string functions
SELECT SPLIT_PART(date_of_birth::TEXT, '-', 1) FROM directors;

SELECT SPLIT_PART(date_of_birth::VARCHAR(20), '-', 1) FROM directors;


-- Challenge 2 : String Functions

--#1 Use the substring function to retrieve the first 6 characters
-- of each movie name and the year they released

SELECT LEFT('string', 3);

SELECT * FROM movies;
-- need to get year as '9999'
SELECT movie_name, LEFT(movie_name, 6) , release_date FROM movies;

-- this works
SELECT movie_name, LEFT(movie_name, 6), SUBSTRING(release_date::TEXT, 1, 4) AS year FROM movies;

-- this works too
SELECT movie_name, SUBSTRING(movie_name, 1, 6) AS movie_name, 
SUBSTRING(release_date::TEXT, 1, 4) AS year FROM movies;



--#2 Retrieve the first name initial and last name of every actor born in May

SELECT * FROM actors;
SELECT SUBSTRING(first_name, 1, 1) AS fn_initial, last_name, date_of_birth FROM actors
WHERE SPLIT_PART(date_of_birth::TEXT, '-', 2) = '05';


SELECT * FROM actors;
SELECT LEFT(first_name, 1) AS fn_initial, last_name, date_of_birth FROM actors
WHERE SPLIT_PART(date_of_birth::TEXT, '-', 2) = '05';


--#3 Replace the movie langauge for all English language movies with age certificate rating 18, to 'Eng'.

SELECT * FROM movies;

-- this does not change the table ONLY runs a query
SELECT movie_lang, REPLACE(movie_lang,'English', 'Eng') FROM movies
WHERE age_certificate::TEXT = '18';

-- this fully updates the table
UPDATE movies
SET movie_lang = REPLACE(movie_lang, 'English', 'Eng')
WHERE age_certificate::TEXT = '18';

-- this changes it back to where is started
UPDATE movies
SET movie_lang = REPLACE(movie_lang, 'Eng', 'English')
WHERE age_certificate::TEXT = '18';




