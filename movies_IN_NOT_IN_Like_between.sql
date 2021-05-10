-- Using IN and NO IN

/*
SELECT columnname1, columnname2 FROM tablename
WHERE solumname3 IN ('value1', 'value2');

SELECT columnname1, columnname2 FROM tablename
WHERE solumname3 NOT IN ('value1', 'value2');
*/

SELECT first_name, last_name FROM actors
WHERE first_name = 'Bruce','John';

SELECT first_name, last_name FROM actors
WHERE first_name IN ('Bruce','John');

SELECT first_name, last_name FROM actors
WHERE first_name IN ('Bruce','John','Peter');

SELECT first_name, last_name FROM actors
WHERE first_name NOT IN ('Bruce','John','Peter');

SELECT actor_id, first_name, last_name FROM actors
WHERE actor_id IN (2,3,4,5,6,8);

SELECT actor_id, first_name, last_name FROM actors
WHERE actor_id NOT IN (2,3,4,5,6,8);

-- Using LIKE with % and _  pattern recognition
/*
SELECT columname FROM tabe
WHERE columname LIKE '%pattern%';

SELECT columname FROM tabe
WHERE columname LIKE _pattern_';
*/

SELECT * FROM actors
WHERE first_name LIKE 'P%';

SELECT * FROM actors
WHERE first_name LIKE 'Pe_';

SELECT * FROM actors
WHERE first_name LIKE '%r';

SELECT * FROM actors
WHERE first_name LIKE '%r%';


SELECT * FROM actors
WHERE first_name LIKE '%rl%';


SELECT * FROM actors
WHERE first_name LIKE '__rl_';

SELECT * FROM actors
WHERE first_name LIKE '__rl__';

-- Selecting data where a column is between 2 values
/*
SELECT columnname1, clumnname2 FROM tablename
WHERE columnname3 BETWEEN value1 AND value2;
*/

SELECT * FROM movies;

SELECT movie_name, release_date FROM movies
WHERE release_date BETWEEN '1995-01-01' AND '1999-12-31';

SELECT movie_name, movie_length FROM movies
WHERE movie_length BETWEEN 90 AND 120;

SELECT movie_name, movie_lang FROM movies
WHERE movie_lang BETWEEN 'E' AND 'P';


SELECT movie_name, movie_lang FROM movies
WHERE movie_lang BETWEEN 'E' AND 'Portuguese';

SELECT movie_name, movie_lang FROM movies
WHERE movie_lang BETWEEN 'Eo' AND 'Portuguese';


-- Challenge
-- #1 Select movie_name and movie_lang of ALL movies with movie_lang of English, Spanish, or Korean.

SELECT movie_name, movie_lang FROM movies
WHERE movie_lang IN ('English','Spanish','Korean');



-- #2 Select first_name and last_name of actors whose last_name begins with M and were born between 01/01/1940 and 31/12/1969.

--SELECT first_name, last_name, date_of_birth FROM actors
SELECT first_name, last_name FROM actors
WHERE last_name LIKE 'M%'
AND date_of_birth BETWEEN '1940-01-01' AND '1969-12-31';

-- #3 Select the first and last names of the directors with nationality of British, French, or German born between 01/01/1950 and 31/12/1980.

--SELECT first_name, last_name, date_of_birth FROM directors
SELECT first_name, last_name FROM directors
WHERE nationality IN ('British','French','German')
AND date_of_birth BETWEEN '1950-01-01' AND '1980-12-31';









































