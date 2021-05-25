

-- Intersect

/*
SELECT column1 FROM table1
INTERSECT
SELECT column1 FROM table2;
*/


SELECT first_name FROM directors
WHERE nationality = 'American'
INTERSECT
SELECT first_name FROM actors
ORDER BY first_name;


-- Except
-- returns table1 data if not returned by table 2
/*
SELECT column1 FROM table1
EXCEPT
SELECT column1 FROM table2;
*/


SELECT first_name FROM directors
WHERE nationality = 'American'
EXCEPT
SELECT first_name FROM actors
ORDER BY first_name;
;

--Challenge 5 : Joins

--#1 Intersect the first name, last name and DOB columns in the directors and actors tables

SELECT first_name, last_name, date_of_birth FROM directors
INTERSECT
SELECT first_name, last_name, date_of_birth FROM actors;


--#2 Retrieve the first names of MALE actors unless they have the same first name as any British directors

SELECT first_name FROM actors
WHERE gender = 'M'
EXCEPT
SELECT first_name FROM directors
WHERE nationality = 'British';


