-- Aggregate Functions : COUNT

/*
SELECT COUNT(columnname) FROM tablename;
*/


SELECT * FROM movie_revenues;
SELECT COUNT(*) FROM movie_revenues;

-- COUNT will not count NULL values
SELECT COUNT(international_takings) FROM movie_revenues;

SELECT COUNT(*) FROM movies;

SELECT COUNT(*) FROM movies
WHERE movie_lang = 'English';



-- Aggregate Functions : SUM

/*
SELECT SUM(columnname) FROM tablename;
*/

SELECT SUM(domestic_takings) FROM movie_revenues;

SELECT SUM(domestic_takings) FROM movie_revenues
WHERE domestic_takings > 100.0;

SELECT SUM(movie_length) FROM movies
WHERE movie_lang = 'Chinese';

-- Cant use on strings

SELECT SUM(movie_name) FROM movies;
-- Cant use on tables 
SELECT SUM(*) FROM movies;


-- Aggregate Functions : MIN and MAX

SELECT MAX(movie_length) FROM movies;

SELECT MIN(movie_length) FROM movies;


SELECT MIN(movie_length) FROM movies
WHERE movie_lang = 'Japanese';

-- works on dates
SELECT MAX(release_date) FROM movies;
SELECT MIN(release_date) FROM movies;

-- varchar - finds the word with the first or last alpha  
SELECT MAX(movie_name) FROM movies;
SELECT MIN(movie_name) FROM movies;



-- Aggregate Functions : AVG

/*
SELECT AVG(columnname) FROM tablename;
*/

SELECT * FROM movies;
SELECT * FROM actors;
SELECT * FROM directors;

SELECT AVG(movie_length) FROM movies;

SELECT AVG(movie_length) FROM movies
WHERE movie_length IS NOT NULL;

SELECT AVG(movie_length) FROM movies
WHERE movie_lang = 'English';

SELECT AVG(movie_length) FROM movies
WHERE age_certificate = '18';


-- Challenge

-- #1 Count number of actors born after the 1st of Jan 1970

SELECT COUNT(*) FROM actors
WHERE date_of_birth > '1970-01-01';


-- #2 What was the highest and lowest domestic takings for a movie?

SELECT MAX(domestic_takings) FROM movie_revenues;
SELECT MIN(domestic_takings) FROM movie_revenues;

-- #3 What is the SUM total movie length for movies rated 15?

SELECT SUM(movie_length) FROM movies
WHERE age_certificate = '15';

-- #4 How many Japanese directors are in the directors table?

SELECT COUNT(*) FROM directors
WHERE nationality = 'Japanese';

-- #5 What s the average movie length for Chinese movies?

SELECT AVG(movie_length) FROM movies
WHERE movie_lang = 'Chinese';


-- Grouping data

/*
SELECT column1, AGGFUN(column2) FROM tablename
GROUP BY column1;
*/

SELECT * FROM movies;

SELECT COUNT(movie_lang) FROM movies;

SELECT movie_lang, COUNT(movie_lang) FROM movies
GROUP BY movie_lang;

SELECT movie_lang, AVG(movie_length) FROM movies
GROUP BY movie_lang;

-- if you forgot to say GROUP BY you get an error saying use GROUP BY or AggFunction
SELECT movie_lang, AVG(movie_length) FROM movies;

-- here we have two columns that we have not agrregated over so we do a GROUP BY on the two columns
-- we will get distinct AVG movie length for each combination of the two columns
SELECT movie_lang, age_certificate, AVG(movie_length) FROM movies
GROUP BY movie_lang, age_certificate;


-- you can use a WHERE clause but it must go before the GROUP BY clause
SELECT movie_lang, age_certificate, AVG(movie_length) FROM movies
WHERE movie_length > 120
GROUP BY movie_lang, age_certificate;


-- you get an error if you put the WHERE after the GROUP BY
SELECT movie_lang, age_certificate, AVG(movie_length) FROM movies
GROUP BY movie_lang, age_certificate
WHERE movie_length > 120;



SELECT movie_lang, MIN(movie_length), MAX(movie_length) FROM movies
WHERE age_certificate = '15'
GROUP BY movie_lang;


SELECT movie_lang, MIN(movie_length), MAX(movie_length) FROM movies
--WHERE age_certificate = '15'
GROUP BY movie_lang;


SELECT movie_lang, AVG(movie_length), MIN(movie_length), MAX(movie_length) FROM movies
WHERE age_certificate = '15'
GROUP BY movie_lang;


SELECT movie_lang, AVG(movie_length), MIN(movie_length), MAX(movie_length) FROM movies
GROUP BY movie_lang;


-- Having clauses
-- are like WHERE clauses but can use AGGFUN to filter and get the data
/*
SELECT column1, AGGFUN(column2) FROM tablename
GROUP BY column1
HAVING AGGFUN(column3) = value;
*/

SELECT movie_lang, COUNT(movie_lang) FROM movies
GROUP BY movie_lang;

-- Note the HAVING clause must come after the GROUP BY clause
SELECT movie_lang, COUNT(movie_lang) FROM movies
GROUP BY movie_lang
HAVING COUNT(movie_lang) > 1;


-- WHERE clause acts on actual column values not aggregate values of a column
-- so if you use a WHERE you get an error

SELECT movie_lang, COUNT(movie_lang) FROM movies
WHERE COUNT(movie_lang) > 1
GROUP BY movie_lang;

-- Key take away is HAVING uses values from aggregate functions and
-- WHERE use values from actual columns
SELECT movie_lang, COUNT(movie_lang) FROM movies
WHERE movie_length > 120
GROUP BY movie_lang
HAVING COUNT(movie_lang) > 1;


-- 2nd Challenge

-- #1 How many directors are there per nationality?

SELECT * FROM directors;

SELECT nationality, COUNT(nationality) FROM directors
GROUP BY nationality;

-- #2 What is the sum total movie length for each age certificate and movie language combination


-- here we have two columns that we have not agrregated over so we do a GROUP BY on the two columns
-- we will get distinct SUM movie length for each combination of the two columns
SELECT movie_lang, age_certificate, SUM(movie_length) FROM movies
GROUP BY movie_lang, age_certificate
ORDER BY movie_lang, age_certificate;


-- #3 Return the movie languages which have a sum total movie length of over 500 minutes
SELECT * FROM movies;


SELECT movie_lang, age_certificate, SUM(movie_length) FROM movies
GROUP BY movie_lang, age_certificate
HAVING SUM(movie_length) > 500;

SELECT movie_lang,  SUM(movie_length) FROM movies
GROUP BY movie_lang
HAVING SUM(movie_length) > 500;

