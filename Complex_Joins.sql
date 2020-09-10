-- Complex Joins

-- Find employees who haven't made any sales and the name of the dealership they work at.
SELECT
	e.first_name,
    e.last_name,
    d.business_name,
	s.price
FROM employees e
INNER JOIN dealershipemployees de ON e.employee_id = de.employee_id
INNER JOIN dealerships d ON d.dealership_id = de.dealership_id
LEFT JOIN sales s ON s.employee_id = e.employee_id
WHERE s.price IS NOT NULL;

-- Get all the dealerships in the database,
-- all the employees in the database and the floor price of any vehicle they have sold.
SELECT
	d.business_name,
	e.first_name,
    e.last_name,
	v.floor_price
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
INNER JOIN employees e ON e.employee_id = de.employee_id
INNER JOIN sales s ON s.employee_id = e.employee_id
INNER JOIN vehicles v ON s.vehicle_id = v.vehicle_id;

-- Use a self join to list all sales that will be picked up on the same day,
-- including the full name of customer picking up the vehicle. .
SELECT
	CONCAT  (c.first_name, ' ', c.last_name) AS cust_name,
	s1.invoice_number,
    s1.pickup_date
FROM
    sales s1
INNER JOIN sales s2
    ON s1.sale_id <> s2.sale_id AND
       s1.pickup_date = s2.pickup_date
INNER JOIN customers c
	ON c.customer_id = s1.customer_id;


-- Get employees and customers who have interacted through a sale.
-- Include employees who may not have made a sale yet.
-- Include customers who may not have completed a purchase.

SELECT
	e.first_name AS employee_first_name,
	e.last_name AS employee_last_name,
	c.first_name AS customer_first_name,
	c.last_name AS customer_last_name
FROM
	employees e
FULL OUTER JOIN sales s
        ON e.employee_id = s.employee_id
FULL OUTER JOIN customers c
        ON s.customer_id = c.customer_id;

-- Get a list of all dealerships and which roles each of the employees hold.
SELECT
	d.business_name,
	et.name
FROM dealerships d
LEFT JOIN dealershipemployees de
	ON d.dealership_id = de.dealership_id
INNER JOIN employees e
	ON de.employee_id = e.employee_id
RIGHT JOIN employeetypes et
	ON e.employee_type_id = et.employee_type_id
	
	ORDER BY d.business_name;
-- 	ORDER BY et.name;
	
	
	
-- Practice: Sales Type by Dealership 

-- #1 Produce a report that lists every dealership, the number of purchases done by each, and the number of leases done by each.
SElECT 
d.business_name AS Dealership, st.name, COUNT(s.sale_id) as number_of_sales
-- st.name
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.sales_type_id = 1
GROUP BY d.dealership_id	
ORDER BY d.dealership_id;


SElECT 
d.business_name AS Dealership, COUNT(s.sale_id) as number_of_sales
-- st.name
FROM dealerships d
JOIN sales s
ON s.dealership_id = d.dealership_id
JOIN salestypes st
ON s.sales_type_id = st.sales_type_id
WHERE st.sales_type_id = 2
GROUP BY d.dealership_id	
ORDER BY d.dealership_id;

--OR
-- this version does a GROUP BY with two inputs - first we group by dealerships and then we group within the dealerships by sales types
-- next we use Group By on dealerships to sort them together 
SElECT 
d.business_name AS Dealership, st.name, COUNT(s.sale_id) AS number_of_sales
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
GROUP BY d.dealership_id, st.sales_type_id	
ORDER BY d.dealership_id;

-- OR

-- This is Heidi's versions
SELECT business_name, COUNT(sp.sale_id) AS purchases, COUNT(sl.sale_id) AS leases
FROM Dealerships d
LEFT JOIN sales sp ON sp.dealership_id = d.dealership_id AND sp.sales_type_id = 1
LEFT JOIN sales sl ON sl.dealership_id = d.dealership_id AND sl.sales_type_id = 2
GROUP BY business_name


-- Practice: Leased Types
-- #2 Produce a report that determines the most popular vehicle model that is leased.

SELECT mo.name, COUNT(s.sale_id) AS lease_count
FROM sales s
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclemodels mo ON mo.vehicle_model_id = vt.model_id
WHERE st.sales_type_id = 2
GROUP BY mo.vehicle_model_id
ORDER BY COUNT(s.sale_id) DESC;

--OR  just change the st.sales_type_id = 1 to get the sales count of most popular car model

SELECT mo.name, COUNT(s.sale_id) AS purchase_count
FROM sales s
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclemodels mo ON mo.vehicle_model_id = vt.model_id
WHERE st.sales_type_id = 1
GROUP BY mo.vehicle_model_id
ORDER BY COUNT(s.sale_id) DESC;




-- Who Sold What
-- #3 What is the most popular vehicle make in terms of number of sales?
SELECT ma.name, COUNT(s.sale_id) AS number_of_sales

FROM sales s
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclemakes ma ON vt.make_id = ma.vehicle_make_id
GROUP BY ma.vehicle_make_id
ORDER BY COUNT(s.sale_id) DESC;

-- #4 Which employee type sold the most of that make?

SELECT et.name, COUNT(s.employee_id)
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclemakes ma ON ma.vehicle_make_id = vt.make_id
JOIN employees e ON s.employee_id = e.employee_id
JOIN employeetypes et ON et.employee_type_id = e.employee_type_id
WHERE ma.vehicle_make_id =
(
-- this inner query finds the most popular make by its ID so it can be used by the outer query
SELECT ma.vehicle_make_id
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclebodytypes bt ON vt.body_type_id = bt.vehicle_body_type_id
JOIN vehiclemakes ma ON vt.make_id = ma.vehicle_make_id
GROUP BY ma.vehicle_make_id
ORDER BY COUNT(s.sale_id) DESC
LIMIT 1
)
GROUP BY et.employee_type_id
ORDER BY COUNT(s.employee_id) DESC;










