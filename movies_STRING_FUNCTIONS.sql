
-- UPPER AND LOWER FUNCTIONS

/*
SELECT UPPER('string');

SELECT LOWER('lower');

SELECT UPPER(column_name) FROM table_name;

SELECT LOWER(column_name) FROM table_name;
*/

SELECT UPPER('stop shouting');

-- only changes the results not the table
SELECT first_name, UPPER(last_name) AS last_name FROM actors;

SELECT * FROM actors;

SELECT LOWER('StOP SHoutiNG');


SELECT LOWER(movie_name) FROM movies;

SELECT movie_name FROM movies;

-- INITCAP STRING FUNCTION

/*
SELECT INITCAT('example string');

SELECT INITCAP(column_name) FROM table_name;
*/

SELECT INITCAP('eXample sTRING');

SELECT movie_name FROM movies;

SELECT INITCAP(movie_name) FROM movies;


-- LEFT AND RIGHT STRING FUNCTIONS

/*
SELECT LEFT('string', int);

SELECT LEFT(column_name, int) FROM table_name;

SElECT RIGHT('string', int);

SELECT RIGHT(column_name, int);
*/

SELECT LEFT('string', 3);
SELECT LEFT('string', 4);
SELECT LEFT('string', -5);
SELECT LEFT('string', -1);

SELECT LEFT(movie_name, 5) FROM movies;


SELECT RIGHT('string', 3);

SELECT RIGHT('example', 3);
SELECT RIGHT('example', -3);

-- last 2 letters in the first name of actors
SELECT RIGHT(first_name, 2) FROM actors;

SELECT * FROM actors;


-- REVERSE FUNCTION

/*
SELECT REVERSE('string');

SELECT REVERSE(column_name) FROM table_name;
*/

SELECT REVERSE('reverse');

SELECT REVERSE(REVERSE('reverse'));

SELECT REVERSE(REVERSE(REVERSE('reverse')));

SELECT REVERSE(REVERSE(REVERSE('reverse')));

SELECT REVERSE(REVERSE(REVERSE(REVERSE('reverse'))));

SELECT movie_name, REVERSE(movie_name) FROM movies;

-- Challenge 1: String Functions

--#1 Select the directors first and last names and movie names in upper case

SELECT UPPER(d.first_name) AS first_name, UPPER(d.last_name) AS last_name, UPPER(mo.movie_name) AS movie_name FROM directors d
JOIN movies mo ON mo.director_id = d.director_id;


--#2 Select the first and last names in initial capitalisation format, of all
-- the actors who have starred in a Chinese or Korean movie

SELECT DISTINCT INITCAP(ac.first_name) AS first_name, INITCAP(ac.last_name) AS last_name, mo.movie_lang FROM actors ac
JOIN movies_actors ma ON ma.actor_id = ac.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
WHERE mo.movie_lang = 'Chinese'
OR mo.movie_lang ='Korean'
ORDER BY mo.movie_lang;


--SELECT INITCAP(ac.first_name) AS first_name, INITCAP(ac.last_name) AS last_name, mo.movie_lang FROM actors ac
-- in this example we remove duplicates with the DISTINCT 
SELECT DISTINCT INITCAP(ac.first_name) AS first_name, INITCAP(ac.last_name) AS last_name FROM actors ac
JOIN movies_actors ma ON ma.actor_id = ac.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
WHERE mo.movie_lang IN ('Chinese', 'Korean');

SELECT * FROM movies_actors;


--#3 Retrieve the reversed first and last names of each directors and first three characters of the nationality

SELECT 
REVERSE(first_name) AS first_name_rev, 
REVERSE(last_name) AS last_name_rev, 
LEFT(nationality, 3) AS nationality_abrev 
FROM directors;

--#4 Retrieve the initials of each director and display it in one column named 'initials'

SELECT CONCAT(LEFT(first_name, 1), LEFT(last_name, 1)) AS initials FROM directors; 

SELECT CONCAT_WS('.', LEFT(first_name, 1), LEFT(last_name, 1)) AS initials, first_name, last_name FROM directors; 

SELECT * FROM directors;

/*
SELECT 'string1' || 'string2' AS new_string;
SELECT CONCAT(column1, column2) AS new_column FROM tablename;
SELECT CONCAT_WS(' ',column1, column2) AS new_column FROM tablename;
*/







