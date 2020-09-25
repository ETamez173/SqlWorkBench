EXPLAIN SELECT
	d.business_name,
	et.name
FROM dealerships d
LEFT JOIN dealershipemployees de
	ON d.dealership_id = de.dealership_id
INNER JOIN employees e
	ON de.employee_id = e.employee_id
RIGHT JOIN employeetypes et
	ON e.employee_type_id = et.employee_type_id;
	
	
	
	
	
	EXPLAIN ANALYZE SELECT
	d.business_name,
	et.name
FROM dealerships d
LEFT JOIN dealershipemployees de
	ON d.dealership_id = de.dealership_id
INNER JOIN employees e
	ON de.employee_id = e.employee_id
RIGHT JOIN employeetypes et
	ON e.employee_type_id = et.employee_type_id;
	
	
	-- Let's take a look at how some of our queries perform? Take notes of how each query performs. Then create indexes for each query below. Rerun your queries to see if they improve. If they do not improve, why?

-- #1 example

EXPLAIN SELECT * from Employees WHERE employee_type_id = 1
EXPLAIN ANALYZE SELECT * from Employees WHERE employee_type_id = 1

CREATE INDEX emp_type_id_index ON employees
(
    employee_type_id
  );


-- #2 example
	
    SELECT * from Sales WHERE dealership_id = 500;
	EXPLAIN SELECT * from Sales WHERE dealership_id = 500;
	EXPLAIN ANALYZE SELECT * from Sales WHERE dealership_id = 500;

CREATE INDEX sales_dealership_id_500_index ON sales
(
    dealership_id 
  );

-- #3 example

SELECT * from customers WHERE state = 'CA';
EXPLAIN SELECT * from customers WHERE state = 'CA';
EXPLAIN ANALYZE SELECT * from customers WHERE state = 'CA';


CREATE INDEX state_CA_index ON customers
(
    state
  );

-- #4 example

SELECT * from vehicles where year_of_car BETWEEN 2018 AND 2020;
EXPLAIN SELECT * from vehicles where year_of_car BETWEEN 2018 AND 2020;
EXPLAIN ANALYZE SELECT * from vehicles where year_of_car BETWEEN 2018 AND 2020;


-- CREATE INDEX BETWEEN_2018_AND_2020_index ON vehicles
CREATE INDEX BETWEEN_YEAR_AND_YEAR_index ON vehicles
(
    year_of_car
  );


-- #5 example

SELECT * from vehicles where floor_price < 30000;
EXPLAIN SELECT * from vehicles where floor_price < 30000;
EXPLAIN ANALYZE SELECT * from vehicles where floor_price < 30000;


CREATE INDEX floor_price_index ON vehicles
(
    floor_price
  );

	
	