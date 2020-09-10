-- Get a list of the sales that was made for each sales type.

-- SELECT
-- --     *
-- salestypes.name, sales.customer_id

-- FROM
--     sales
-- INNER JOIN salestypes
--     ON sales.sales_type_id = salestypes.sales_type_id
-- 	ORDER BY salestypes.sales_type_id;
	

-- Get a list of sales with the VIN of the vehicle, the first name and last name of the customer, first name and last name of the employee who made the sale and the name, city and state of the dealership.

-- SELECT

-- s.sale_id, v.vin, c.first_name, c.last_name, e.first_name, e.last_name
-- -- *
-- FROM
--     customers c

-- INNER JOIN sales s
--     ON s.customer_id = c.customer_id
	
-- INNER JOIN employees e
--     ON s.employee_id = e.employee_id

-- INNER JOIN vehicles v
--     ON v.vehicle_id = s.vehicle_id;
	

-- Get a list of all the dealerships and the employees, if any, working at each one.
-- Left Join

-- SELECT d.business_name, e.first_name, e.last_name
-- FROM dealerships d
-- LEFT JOIN employees e
-- ON e.dealership_id = d.dealership_id
-- ORDER BY d.business_name




-- Get a list of vehicles with the names of the body type, make, model and color.

SELECT vt.body_type, vt.make, vt.model, v.exterior_color 

FROM vehicletypes vt
INNER JOIN vehicles v
ON vt.vehicle_type_id = v.vehicle_type_id
ORDER BY vt.make
-- Order By  vt.body_type





