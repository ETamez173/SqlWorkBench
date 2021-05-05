-- Select queries

SELECT * FROM directors;

SELECT first_name FROM directors;

SELECT first_name, last_name FROM directors;

SELECT first_name, last_name, nationality FROM directors;

-- Retrieving data with a where clause

/*

SELECT columnname FROM tablename
WHERE columnname = 'value';

*/

SELECT * FROM movies;

SELECT * FROM movies
WHERE age_certificate = '15'
AND movie_lang = 'Chinese';
-- Note above that age_certificate is a VARCHAR and reguires '15' and vs 15 if it was an INT

SELECT * FROM movies
WHERE age_certificate = '15'
OR movie_lang = 'Chinese';

SELECT * FROM movies
WHERE movie_lang = 'English'
AND age_certificate = '15'
AND director_id =27;

-- Uisng logical operators ( > , >=,<, <=) Note the = comes after the < or >

SELECT movie_name, movie_length FROM movies
WHERE movie_length > 120;

SELECT movie_name, movie_length FROM movies
WHERE movie_length >= 120;

SELECT movie_name, movie_length FROM movies
WHERE movie_length < 120;

SELECT movie_name, movie_length FROM movies
WHERE movie_length <= 120;


SELECT * FROM Movies
WHERE release_date > '1999-12-31';

SELECT * FROM Movies
WHERE release_date < '1999-12-31';

SELECT * FROM Movies
WHERE movie_lang < 'English';

-- Challenge!

SELECT * FROM movies;

-- #1 select movie_name and release_date of every movie

SELECT movie_name, release_date FROM movies;


-- #2 select first and last names of all American directors

SELECT * FROM directors;

SELECT first_name, last_name FROM directors
WHERE nationality = 'American';

-- #3 Select all male actors born after the 1st of Jan 1970

SELECT * FROM actors;

SELECT * FROM actors
WHERE gender = 'M'
AND date_of_birth > '1970-01-01';

-- #4 Select names of all movies which are over 90 minutes long and movie language is English

SELECT * FROM movies;

SELECT movie_name FROM movies
WHERE movie_length > 90
AND movie_lang = 'English';





