--Uncorrelated Subqueries
--Note you can run the sub query by itself in an Uncorrelated Subquery scenario

SELECT movie_name, movie_length FROM movies
WHERE movie_length >
(SELECT AVG(movie_length) FROM movies);

SELECT AVG(movie_length) FROM movies;

--find the first and last names of the directors that are older than diretor James Cameron

SELECT first_name, last_name, date_of_birth FROM directors
WHERE date_of_birth > 

(SELECT date_of_birth FROM directors
WHERE first_name = 'James'
AND last_name = 'Cameron');



SELECT first_name, last_name, date_of_birth FROM directors
WHERE date_of_birth > 
(SELECT date_of_birth FROM actors
WHERE first_name = 'Tom'
AND last_name = 'Cruise');

--Uncorrelated Subqueries Part 2
--by passing values from inner query to outer query using IN keyword



SELECT movie_name FROM movies
WHERE movie_id IN
(SELECT movie_id FROM movie_revenues
WHERE international_takings > domestic_takings);

--we can JOIN tables while using Subqueries

SELECT mo.movie_name, d.first_name, d.last_name FROM movies mo
JOIN directors d ON d.director_id = mo.director_id
WHERE movie_id IN
(SELECT movie_id FROM movie_revenues
WHERE international_takings > domestic_takings);

-- Challenge 1 : Subqueries

-- #1 Select the first and last names of all actors older than Marlon Brando
-- use uncorrelated sub-query
SELECT * FROM actors;

SELECT first_name, last_name FROM actors
WHERE date_of_birth <
(SELECT date_of_birth FROM actors
WHERE first_name = 'Marlon'
AND last_name = 'Brando');


-- #2 Select the movie names of all movies that domestic takings above 300 million
-- use uncorrelated sub-query
SELECT movie_name FROM movies WHERE
movie_id IN 
(SELECT movie_id FROM movie_revenues
WHERE domestic_takings > 300.0);

SELECT movie_id FROM movie_revenues
WHERE domestic_takings > 300.0;

-- this adds a join to be able to see the domestic_takings amounts and sorts from hight to low
SELECT mo.movie_name, mr.domestic_takings FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id
WHERE
mo.movie_id IN 
(SELECT movie_id FROM movie_revenues
WHERE domestic_takings > 300)
ORDER BY domestic_takings DESC;

--#3 Return the shortest and longest movie length for movies with above average domestic takings

--this attempt came up with MIN of 91 
SELECT MIN(movie_length), MAX(movie_length) FROM movies mo
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id
WHERE
mr.domestic_takings >
(SELECT AVG(domestic_takings) FROM movie_revenues);

-- tried a UNION and it worked but it was long and duplicated the SQL needed
SELECT MIN(movie_length), MAX(movie_length) FROM movies mo
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id
WHERE
mr.domestic_takings >
(SELECT AVG(domestic_takings) FROM movie_revenues)
UNION 
SELECT MIN(movie_length), MAX(movie_length) FROM movies mo
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id
WHERE
mr.domestic_takings >
(SELECT AVG(domestic_takings) FROM movie_revenues);

--actual solution comes up with MIN of 91
-- this nested query within a nested query is much cleaner 
SELECT MIN(movie_length), MAX(movie_length) FROM movies
WHERE movie_id IN
(SELECT movie_id FROM movie_revenues
WHERE domestic_takings > 
(SELECT AVG(domestic_takings) FROM movie_revenues));


-- here is another solution
SELECT MIN(mo.movie_length), MAX(mo.movie_length) FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id
WHERE mr.domestic_takings >
(SELECT AVG(domestic_takings) FROM movie_revenues);


-- Correlated Subqueries
-- the inner query refers to a table in the outer query / needs it to run

SELECT d1.first_name, d1.last_name, d1.date_of_birth 
FROM directors d1
WHERE d1.date_of_birth =
(Select MIN(date_of_birth) FROM directors d2
WHERE d2.nationality = d1.nationality);

-- this gives an error since it doesnt know what d1 is
Select MIN(date_of_birth) FROM directors d2
WHERE d2.nationality = d1.nationality;



SELECT mo1.movie_name, mo1.movie_lang, mo1.movie_length FROM movies mo1
WHERE mo1.movie_length = 
(SELECT MAX(movie_length) FROM movies mo2
WHERE mo2.movie_lang = mo1.movie_lang);


SELECT MAX(movie_length) FROM movies;



