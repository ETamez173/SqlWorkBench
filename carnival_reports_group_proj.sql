-- Employee Reports

-- Best Sellers

-- #1 Who are the top 5 employees for generating sales income?

--GOOD solution
SELECT e.first_name, e.last_name, e.employee_id, SUM(s.price) as Revenue
FROM sales s
JOIN employees e ON e.employee_id = s.employee_id
WHERE s.sales_type_id = 1
GROUP BY e.employee_id 
ORDER BY revenue DESC
LIMIT 5
--GOOD solution

SELECT e.first_name, e.last_name, e.employee_id
FROM sales s
JOIN employees e ON e.employee_id = s.employee_id
ORDER BY e.employee_id;

JOIN salestypes st ON s.sales_type_id = st.sales_type_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclemakes ma ON vt.make_id = ma.vehicle_make_id
GROUP BY ma.vehicle_make_id
ORDER BY COUNT(s.sale_id) DESC;


-- #2 Who are the top 5 dealership for generating sales income?

SELECT d.business_name AS Dealership, SUM(s.price) as Revenue
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
WHERE s.sales_type_id = 1
GROUP BY d.dealership_id
ORDER BY COUNT(s.sale_id) DESC
LIMIT 5;

-- #3 Which vehicle model generated the most sales income?

SELECT mo.name as Model,  SUM(s.price) as Revenue
FROM sales s
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclemodels mo ON mo.vehicle_model_id = vt.model_id
WHERE st.sales_type_id = 2
GROUP BY mo.vehicle_model_id
ORDER BY Revenue DESC
LIMIT 1;


-- Top Performance
-- #1 Which employees generate the most income per dealership?

SELECT d.business_name, CONCAT(e.first_name, ' ', e.last_name) AS "Sales Heroe" 
FROM dealerships d
JOIN employees e ON e.employee_id = 

									(SELECT e.employee_id
									FROM sales s
									JOIN employees e ON s.employee_id = e.employee_id
									WHERE s.dealership_id = d.dealership_id
									GROUP BY e.employee_id, s.dealership_id
									ORDER BY SUM(s.price) DESC
									LIMIT 1
									)
ORDER BY d.dealership_id;



-- Dealership Reports

-- Inventory

#1 In our Vehicle inventory, show the count of each Model that is in stock.

SELECT mo.name, COUNT(mo.vehicle_model_id) AS Stock
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclemodels mo ON vt.model_id = mo.vehicle_model_id
GROUP BY mo.vehicle_model_id
ORDER BY Stock DESC;


#2 In our Vehicle inventory, show the count of each Make that is in stock.

SELECT ma.name, COUNT(ma.vehicle_make_id) AS Make
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclemakes ma ON vt.model_id = ma.vehicle_make_id
GROUP BY ma.vehicle_make_id
ORDER BY Make DESC;


#3 In our Vehicle inventory, show the count of each BodyType that is in stock.

SELECT bt.name, COUNT(bt.vehicle_body_type_id) AS Body_Inv
FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclebodytypes bt ON bt.vehicle_body_type_id = vt.body_type_id 
GROUP BY bt.vehicle_body_type_id
ORDER BY Body_Inv DESC;

-- Purchasing Power
-- #1 Which US state's customers have the highest average purchase price for a vehicle?

SELECT c.state, ROUND(AVG(s.price)) AS "Avg Price"
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.state
ORDER BY "Avg Price" DESC
Limit 1;

-- #2 Now using the data determined above, which 5 states have the customers with the highest average purchase price for a vehicle?


(
SELECT c.state, ROUND(AVG(s.price)) AS "Avg Price"
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.state
ORDER BY "Avg Price" DESC
	LIMIT 5;
	
	)


