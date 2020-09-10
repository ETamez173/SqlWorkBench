--Practice: BOOK 2 CHAPTER 2

-- #1 Get a list of sales records where the sale was a lease.
SELECT *, sales_type_id
As "Lease" FROM sales
WHERE sales_type_id = 2 


-- #2 Get a list of sales where the purchase date is within the last two years.
SELECT * 
FROM sales
WHERE purchase_date BETWEEN '2018-08-30' AND '2020-08-30'
ORDER BY purchase_date DESC;

SELECT * 
FROM sales
WHERE purchase_date < '2020-08-30' AND purchase_date > '2018-08-30'
ORDER BY purchase_date DESC;

SELECT * 
FROM sales s
WHERE purchase_date >= CURRENT_DATE - '2 Years':: interval
ORDER BY purchase_date DESC;




-- #3 Get a list of sales where the deposit was above 5000 or the customer payed with American Express.

SELECT * 
FROM sales
WHERE deposit > '5000' OR payment_method = 'americanexpress'

--#4 Get a list of employees whose first names start with "M" or ends with "E".

SELECT *
FROM employees
WHERE first_name LIKE 'M%' OR first_name LIKE '%e'


--#5 Get a list of employees whose phone numbers have the 600 area code.

SELECT *
FROM employees
WHERE phone ILIKE '600%'

