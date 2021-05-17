-- Using Mathematical Operators

/*

+ - / * %

*/


SELECT 5 + 6 AS ADDITION;

SELECT 8 - 3 AS SUBTRACTION;

SELECT 30 / 3 AS DIVISION;

SELECT 35 / 3 AS DIVISION;

SELECT 4 * 6 AS MULTIPLICATION;


SELECT 15 % 4 AS MODULUS;



SELECT * FROM movie_revenues;

-- Note if there is a NULL in one of the two columns the result will be NULL
SELECT movie_id, (domestic_takings + international_takings) AS total_takings FROM movie_revenues;


-- Database relationships

/*

Challenge 
--#1 What type of relationship between pets and owners tables?

ANSWER 
Owners 1 to many Pets

-- #2 What type of relationship between addresses and owners tables?
Owner can have more than one address so I say (owners 1 to many addresses)
AND 
More than one owner can live at an address (owners 1 to many -join table- many to 1 addresses)

ANSWER 
addresses and owners tables is a many to many 
simple option is 1 to many 95% of time

-- #3
songs table
playlists table
users table

users can have one or more playlists - so 1 to many OR many to many
playlists can only have one user - 1 to many only

playlists can have one or more songs - so 1 to many or many to many
songs can have one or more playlists - many to many

ANSWER 
users have 1 to many with playlists
playlists have many to many with songs





*/