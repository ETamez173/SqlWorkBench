


-- MAX statement to find the Highest Price in the sales table:
-- SELECT MAX(price) FROM sales;


-- MIN statement to find the Lowest Price in the sales table:
-- SELECT MIN(price) FROM sales;


-- COUNT statement to find the total number of Sales in a table:
-- SELECT COUNT(*) FROM sales;


-- COUNT statement to find how many sales have a price greater than 50,000:
-- SELECT COUNT(price) FROM sales where price > 50000;


-- AVG statement to find the average price for sales in table:
-- SELECT AVG(price) FROM sales;


-- SUM statement to find the total reveneue of all sales made:
-- SELECT SUM(price) FROM sales;



-- Here we want to query a list of sales grouped by the employee who made the sale
SELECT price employee_id, sales_type_id, count(sales_type_id)
FROM sales GROUP BY employee_id



-- Here we want to query a list of sales using the sales_type_id and find how many times a particular saels type occurs.

-- SELECT sales_type_id, count(sales_type_id)
-- FROM sales GROUP BY sales_type_id;