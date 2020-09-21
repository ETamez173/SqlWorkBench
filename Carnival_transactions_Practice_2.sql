-- Practice
-- Help out HR fast track turnover by providing the following:

-- Create a stored procedure with a transaction to handle hiring a new employee. Add a new record for the employee in the Employees table and add a record 
-- to the Dealershipemployees table for the two dealerships the new employee will start at.

BEGIN

CREATE OR REPLACE PROCEDURE new_employee(IN first_name varchar, IN last_name varchar, IN email_address varchar,
							  IN phone varchar, IN employee_type_id int,										 
-- 							  INOUT employee_id int,
							   IN dealership_id_1 int, IN dealership_id_2 int)
LANGUAGE plpgsql
AS $$
BEGIN

INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id) 
VALUES (first_name, last_name, email_address, phone, employee_type_id);
INSERT INTO dealershipemployees(employee_id, dealership_id) VALUES (employee_id, dealership_id_1);
INSERT INTO dealershipemployees(employee_id, dealership_id) VALUES (employee_id, dealership_id_2);

END
$$;

ROLLBACK



-- test
CALL new_employee('Salburt', 'Sanders','ss@gmail.com', '111-111-1111')


--===========================================================================================================
CREATE OR REPLACE PROCEDURE new_employee(IN first_name varchar,IN last_name varchar, 
							IN email_address varchar,
							  IN phone varchar, IN employee_type_id int, 
							 IN dealership_id_1 int, IN dealership_id_2 int)
LANGUAGE plpgsql
AS $$
DECLARE 
  NewEmployeeId integer;
BEGIN
INSERT INTO employees (first_name, last_name, email_address, phone, employee_type_id) 
	VALUES (first_name, last_name, email_address, phone, employee_type_id)
	RETURNING employee_id INTO NewEmployeeId;
INSERT INTO dealershipemployees (employee_id, dealership_id) VALUES (NewEmployeeId, dealership_id_1);
INSERT INTO dealershipemployees (employee_id, dealership_id) VALUES (NewEmployeeId,dealership_id_2);
END
$$;

-- test
CALL new_employee('Salburt', 'Sanders','ss@gamil.com', '111-111-2222', 4, 1, 3);

DROP PROCEDURE new_employee(IN first_name varchar,IN last_name varchar, 
							IN email_address varchar,
							  IN phone varchar, IN employee_type_id int, 
							 IN dealership_id_1 int, IN dealership_id_2 int)
							 
-- TEST							 
SELECT * FROM employees WHERE first_name = 'Salburt';	
SELECT * FROM dealershipemployees WHERE employee_id = 1005;

--===========================================================================================================

-- Create a stored procedure with a transaction to handle an employee leaving. The employee record is removed and all records associating the employee 
-- with dealerships must also be removed.