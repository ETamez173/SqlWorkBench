-- Ordering the results returned 
-- ORDER BY, LIMIT, FETCH, DISTINCT

/*
SELECT columnname1, columnname2 FROM tablename
ORDER BY columnname3;
*/

SELECT * FROM actors;

SELECT first_name, last_name, date_of_birth FROM actors
ORDER BY first_name;

SELECT first_name, last_name, date_of_birth FROM actors
ORDER BY first_name DESC;

SELECT actor_id, first_name, last_name, date_of_birth FROM actors
ORDER BY actor_id DESC;

SELECT first_name, last_name, date_of_birth FROM actors
ORDER BY date_of_birth DESC;

-- add the WHERE clause before the ORDER BY clause
SELECT first_name, last_name, date_of_birth, gender FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC;


-- Limiting the number of records returned

/*
SELECT columnname1, columnname2 FROM tablename
LIMIT N;
*/

SELECT * FROM movie_revenues;


SELECT * FROM movie_revenues
ORDER BY domestic_takings;

SELECT * FROM movie_revenues
ORDER BY domestic_takings
LIMIT 3;

-- OFFSET 

SELECT * FROM movie_revenues
ORDER BY revenue_id
LIMIT 5 OFFSET 3;



-- Using FETCH
/*
SELECT columnname1 FROM table1
FETCH FIRST 1 ROW ONLY;
*/

SELECT movie_id, movie_name FROM movies
FETCH FIRST 2 ROW ONLY;

SELECT movie_id, movie_name FROM movies
FETCH FIRST 10 ROW ONLY;

SELECT movie_id, movie_name FROM movies
OFFSET 8
FETCH FIRST 10 ROW ONLY;


-- Distinct values

/*
SELECT DISTINCT columnname FROM tablename;
*/

SELECT movie_lang FROM movies
ORDER BY movie_lang;


SELECT DISTINCT movie_lang FROM movies
ORDER BY movie_lang;


SELECT DISTINCT movie_lang, age_certificate FROM movies
ORDER BY movie_lang;


-- this only returns disctinct rows that dont have duplicate/repeated data 
SELECT DISTINCT * FROM movies
ORDER BY movie_lang;

SELECT * FROM movies;


-- Challenge
-- #1 Select the American directors ordered from oldest to youngest

SELECT * FROM directors;

SELECT * FROM directors
WHERE nationality = 'American'
ORDER BY date_of_birth ASC;

-- #2 Return the distinct nationalities from the directors table

SELECT DISTINCT nationality FROM directors;


-- #3 Return the first_name, last_name, and dob of the 10 youngest female actors.

--SELECT first_name, last_name, date_of_birth, gender FROM actors
SELECT first_name, last_name, date_of_birth FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
LIMIT 10;






