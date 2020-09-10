--#1 Get a list of the sales that was made for each sales type.


SELECT 
s.*, st.name as "Sales Type"
FROM
sales s
INNER JOIN salestypes st ON st.sales_type_id = s.sales_type_id;
-- JOIN auto defaults to INNER JOIN unless you specify!!

-- #2 Get a list of sales with the VIN of the vehicle, the first name and last name of the customer, first name and last name of the employee who made the sale and the name, city and state of the dealership.

SELECT 
v.vin,
c.first_name as cust_first_name,
c.last_name as cust_last_name,
e.first_name as emp_first_name,
e.last_name as emp_last_name,
d.business_name as dealer,
d.city,
d.state

FROM sales s
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN customers c ON s.customer_id = c.customer_id
JOIN employees e ON s.employee_id = e.employee_id
JOIN dealerships d ON s.dealership_id = d.dealership_id;

SELECT
v.vin, 
c.first_name as cust_first_name, 
c.last_name as cust_last_name, 
e.first_name as emp_first_name, 
e.last_name as empl_last_name, 
d.business_name,
d.city,
d.state

FROM sales s

INNER JOIN customers c ON s.customer_id = c.customer_id
	
INNER JOIN employees e ON s.employee_id = e.employee_id

INNER JOIN vehicles v ON v.vehicle_id = s.vehicle_id
	
INNER JOIN dealerships d ON d.dealership_id = s.dealership_id;

--#3 Get a list of all the dealerships and the employees, if any, working at each one.

SELECT d.business_name as "Business",
       CONCAT(e.first_name, ' ', e.last_name) as employee_name
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
LEFT JOIN employees e ON e.employee_id = de.employee_id;

--Note you need to join thru the "dealershipemployees" join table since there is no direct connection between employees and dealerships

--#4 Get a list of vehicles with the names of the body type, make, model and color.

SELECT 
v.vin,
bt.name as "Body Type",
ma.name as "Make",
mo.name as "Model",
v.exterior_color as "Color"

FROM vehicles v
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclebodytypes bt ON vt.body_type_id = bt.vehicle_body_type_id
JOIN vehiclemakes ma ON vt.make_id = ma.vehicle_make_id
JOIN vehiclemodels mo ON vt.model_id = mo.vehicle_model_id;







