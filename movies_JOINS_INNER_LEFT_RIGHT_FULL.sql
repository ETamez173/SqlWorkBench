
-- INNER JOINS : PART 1

/*
SELECT table1.column1, table1.column2, table2.column1 FROM table1
INNER JOIN table2 ON table1.column3 = table2.cloumn3;

*/

select * from directors;
SELECT * FROM movies;

-- we add a new record with no movie to see how INNER JOIN only finds records that match ib both tables 
INSERT INTO directors (first_name, last_name, date_of_birth, nationality)
VALUES ('Christopher','Nolan','1970-07-30','British');

-- simple INNER JOIN
SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name
FROM directors
INNER JOIN movies ON directors.director_id = movies.director_id;

-- add WHERE clause to INNER JOIN
SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name
FROM directors
INNER JOIN movies ON directors.director_id = movies.director_id
WHERE movies.movie_lang = 'Japanese';

-- add ORDER BY to INNER JOIN
SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name, movies.movie_length
FROM directors
INNER JOIN movies ON directors.director_id = movies.director_id
WHERE movies.movie_lang = 'Japanese'
ORDER BY movies.movie_length DESC;

-- doesnt matter which table is 1 or 2 - ONLY in INNER JOIN
SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name, movies.movie_length
FROM movies
INNER JOIN directors ON directors.director_id = movies.director_id
WHERE movies.movie_lang = 'Japanese'
ORDER BY movies.movie_length DESC;


-- INNER JOINS : PART 2

/*
SELECT table1.column1, table1.column2, table2.column1 FROM table1
INNER JOIN table2 ON table1.column3 = table2.column3;

SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
JOIN table2 t2 ON t1.column3 = t2.column3;
*/


SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name, movies.movie_length
FROM directors
INNER JOIN movies ON directors.director_id = movies.director_id
WHERE movies.movie_lang = 'Japanese'
ORDER BY movies.movie_length DESC;

-- use shorter methods
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name, mo.movie_length
FROM directors d
JOIN movies mo ON d.director_id = mo.director_id
WHERE mo.movie_lang = 'Japanese'
ORDER BY mo.movie_length DESC;

-- write JOIN for movies and movie revenues int takings and domestic takings

SELECT mo.movie_name, mr.domestic_takings, mr.international_takings FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id;


-- add ORDER BY
SELECT mo.movie_name, mr.domestic_takings, mr.international_takings FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id
ORDER BY mr.domestic_takings;


-- INNER JOINS : PART 3
-- USING clause
-- ONLY WHEN THE JOINING COLUMNS HAVE THE SAME NAME!

/*
SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
JOIN table2 t2 USING (column3);
*/

SELECT * FROM movies;
SELECT * FROM movie_revenues;

SELECT mo.movie_name, mr.domestic_takings FROM movies mo
JOIN movie_revenues mr USING (movie_id);

-- add WHERE and ORDER BY
SELECT mo.movie_name, mr.domestic_takings FROM movies mo
JOIN movie_revenues mr USING (movie_id)
WHERE mo.age_certificate IN('12','15','18')
ORDER BY mr.domestic_takings DESC
;


-- CHALLENGE 1 - JOINS
-- #1 Select the directors first and last names, the movie names and release dates for all Chinese, Korean, and Japanese movies.

--directors
--movies

SELECT * FROM movies;
SELECT * FROM directors;

SELECT d.first_name, d.last_name, mo.movie_name, mo.release_date, mo.movie_lang FROM movies mo
JOIN directors d ON mo.director_id = d.director_id 
WHERE mo.movie_lang IN('Chinese','Korean','Japanese')
ORDER BY mo.movie_lang;

-- #2 Select the movie names, release dates and international takings of all English language movies

-- movies
-- movie_revenues
SELECT * FROM movie_revenues;

--SELECT mo.movie_name, mo.release_date, mo.movie_lang, mr.international_takings FROM movies mo
SELECT mo.movie_name, mo.release_date, mr.international_takings FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id
WHERE mo.movie_lang = 'English'
ORDER BY mr.international_takings;

-- filter for NULL international takings
--SELECT mo.movie_name, mo.release_date, mo.movie_lang, mr.international_takings FROM movies mo
SELECT mo.movie_name, mo.release_date, mr.international_takings FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id
WHERE mo.movie_lang = 'English'
AND mr.international_takings IS NOT null
ORDER BY mr.international_takings;

-- #3 Select the movie names, domestic takings and international takings for all movies with either missing domestic takings or missing
-- international takings and order the results by movie name.

-- movies
-- movie_revenues

SELECT mo.movie_name, mr.domestic_takings, mr.international_takings FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id
WHERE mr.domestic_takings IS NULL 
OR mr.international_takings IS NULL
ORDER BY mo.movie_name;

-- LEFT JOINS

/*
SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
LEFT JOIN table2 ON t1.column3 = t2.column3;
*/

--directors
-- movies
SELECT * FROM movies;
SELECT * FROM directors;

-- we get a record with movie_name = NULL with the LEFT JOIN vs INNER JOIN
-- if we list directors as table1 then we get the NULL since a LEFT JOIN will return ALL the values in table 1 (directors)
-- and only the matching records in table2 (movies)
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
LEFT JOIN movies mo ON mo.director_id = d.director_id;


-- if we switch and make table1 movies and table2 directors we dont get the record with NULL in movies
-- because the LEFT JOIN returns all the rows in movies then ONLY the matching records/ rows in directors
-- since Christophe Nolan doesnt match any table1 aka movie it is not included in the results
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
LEFT JOIN directors d ON mo.director_id = d.director_id;

-- her we add WHERE clause
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
LEFT JOIN movies mo ON mo.director_id = d.director_id
WHERE d.nationality = 'British';

-- RIGHT JOINS

/*
SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
RIGHT JOIN table2 t2 ON t1.column3 = t2.column3; 
*/

-- movies
-- directors

-- RIGHT JOIN will return ALL data from table2 aka movies and ONLY matching data from table1 aka directors 
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
RIGHT JOIN movies mo ON mo.director_id = d.director_id; 

-- switch tables around 
-- this returns Christopher Nolan with the NULL value since directors is table2
-- and a RIGHT JOIN will return ALL data from table2 and ONLY matching data from table1 aka movies
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
RIGHT JOIN directors d ON mo.director_id = d.director_id; 


-- add WHERE clause 
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
RIGHT JOIN directors d ON mo.director_id = d.director_id
WHERE mo.age_certificate = '18'; 


-- FULL OUTER JOINS

/*
SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
FULL JOIN table2 t2 ON t1.column3 = t2.column3;
*/

-- return ALL data from table1 and ALL data from table2

SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
FULL JOIN directors d ON d.director_id = mo.director_id;

-- we flip tables and get the same results
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
FULL JOIN movies mo ON d.director_id = mo.director_id;

-- add WHERE and ORDER BY
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
FULL JOIN movies mo ON d.director_id = mo.director_id
WHERE mo.movie_lang IN ('German','Korean')
ORDER BY d.last_name;


-- CHALLENGE 2 - JOINS 

--#1 Use a left join to select the first and last names of all British directors and the names and age certificates of
-- the movies that they directed

-- directors
-- movies

SELECT * FROM movies;
SELECT * FROM directors;

-- Note making directors table1 allows the row wiht a NULL value for movie_name to returned
-- because LEFT JOINS return ALL rows in table1 and ONLY those that mathc in table2
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name, mo.age_certificate FROM directors d
LEFT JOIN movies mo ON d.director_id = mo.director_id
WHERE d.nationality = 'British';

SELECT d.director_id, d.first_name, d.last_name, mo.movie_name, mo.age_certificate FROM movies mo
LEFT JOIN directors d ON d.director_id = mo.director_id
WHERE d.nationality = 'British';


--#2 Count the number of movies the each director has directed
SELECT * FROM movies;
SELECT * FROM directors;

-- this finds 38 rows - includes Christopher Nolan who has NULL value since he made no movies
SELECT d.first_name, d.last_name, COUNT(mo.movie_id) FROM directors d
LEFT JOIN movies mo ON d.director_id = mo.director_id
GROUP BY d.first_name, d.last_name;


-- this finds 37 rows
SELECT d.first_name, d.last_name, COUNT(mo.movie_id) FROM movies mo
LEFT JOIN directors d ON d.director_id = mo.director_id
GROUP BY d.first_name, d.last_name;



-- Joining More Than Two Tables

/*
SELECT t1.column, t2.column, t3.column, FROM table1 t1
JOIN table2 t2 ON t1.column = t2.column
JOIN table3 t3 ON t3.column = t2.column;
*/

--directors
--movies
SELECT * FROM movie_revenues;

SELECT d.first_name, d.last_name, mo.movie_name, mr.international_takings, mr.domestic_takings
FROM directors d
JOIN movies mo ON d.director_id = mo.director_id
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id;

SELECT * FROM actors;
SELECT * FROM movies_actors;

-- this uses a join table to connect actors and movies tables
SELECT ac.first_name, ac.last_name, mo.movie_name FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
WHERE mo.movie_lang = 'English'
ORDER BY mo.movie_name;


SELECT ac.first_name, ac.last_name, mo.movie_name FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
--WHERE mo.movie_lang = 'English'
ORDER BY mo.movie_name;


-- we want the directors first and last name and the movie name, actors first and last name, and the movie domestc and intl takings
--directors
--movies
--actors
--movie_revenues
--movies_actors (join table)

SELECT d.first_name, d.last_name, mo.movie_name, ac.first_name, ac.last_name,
mr.domestic_takings, mr.international_takings FROM directors d
JOIN movies mo ON mo.director_id = d.director_id
JOIN movies_actors ma ON ma.movie_id = mo.movie_id
JOIN actors ac ON ac.actor_id = ma.actor_id
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id;


-- Challenge 3 : Joins

-- #1 Select the first and last names of all the actors who have starred in movies directed by Wes Anderson

-- actors 
-- movies
-- directors

SELECT * FROM actors;
SELECT * FROM movies;
SELECT * FROM movies_actors;
SELECT * FROM directors;

SELECT * FROM movies_actors;


--SELECT ac.first_name, ac.last_name, mo.movie_name, d.last_name FROM actors ac
SELECT ac.first_name, ac.last_name FROM actors ac
JOIN movies_actors ma ON ma.actor_id = ac.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
JOIN directors d ON d.director_id = mo.director_id
WHERE d.director_id = 3;


SELECT ac.first_name, ac.last_name FROM actors ac
JOIN movies_actors ma ON ma.actor_id = ac.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
JOIN directors d ON d.director_id = mo.director_id
WHERE d.first_name = 'Wes'
AND d.last_name = 'Anderson';


-- # 2 Which director has the highest total domestic takings

-- directors
-- movies
-- movie_revenues

SELECT d.first_name, d.last_name, SUM(mr.domestic_takings) AS total_domestic_takings FROM directors d
JOIN movies mo ON d.director_id = mo.director_id
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id
WHERE mr.domestic_takings IS NOT NULL
GROUP BY d.first_name, d.last_name
ORDER BY total_domestic_takings DESC
limit 1;


-- Union

/*
SELECT column1, column2 FROM table1
UNION
SELECT column1, column2 FROM table2
*/

SELECT d.first_name, d.last_name FROM directors d
UNION
SELECT ac.first_name, ac.last_name FROM actors ac;

SELECT d.first_name, d.last_name, d.date_of_birth FROM directors d
WHERE nationality = 'American'
UNION
SELECT ac.first_name, ac.last_name, ac.date_of_birth FROM actors ac
WHERE gender = 'F'
-- ORDER BY must come after the final SELECT statment in the UNION or may get erronoeus results
ORDER BY first_name;


-- Union ALL


/* Note the UNION ALL will return all records including duplicate ones
SELECT column1, column2 FROM table1
UNION ALL
SELECT column1, column2 FROM table2
*/

SELECT d.first_name FROM directors d
UNION 
SELECT ac.first_name FROM actors ac;

SELECT d.first_name FROM directors d
UNION ALL
SELECT ac.first_name FROM actors ac
ORDER BY first_name;


--Challenge 4 : Joins

--#1 Select the first names, last names and DOB from directors and actors. Order results by DOB

SELECT first_name, last_name, date_of_birth FROM directors
UNION ALL
SELECT first_name, last_name, date_of_birth FROM actors
ORDER BY date_of_birth;

--#2 Select the first and last names of all directors and actors born in the 1960s.  Order by last name

SELECT first_name, last_name, date_of_birth FROM directors
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
UNION ALL
SELECT first_name, last_name, date_of_birth FROM actors
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;


