-- Practice: Carnival
-- #1 Write a transaction to:
-- Add a new role for employees called Automotive Mechanic
-- Add five new mechanics, their data is up to you
-- Each new mechanic will be working at all three of these dealerships: Sollowaye Autos of New York, Hrishchenko Autos of New York and Cadreman Autos of New York

BEGIN;

SELECT * FROM employeetypes;

INSERT INTO public.employeetypes(name)
	VALUES ('Automotive Mechanic');
	
INSERT INTO employees(
first_name, last_name, email_address, phone, employee_type_id)
VALUES 
('Joey', 'Johnson', 'joeyj101@gmail.com', '615-555-9191', 9),
('Janey', 'Jones', 'janey999@gmail.com', '615-555-0101', 9),
('Bill', 'Williams', 'billybill@gmail.com', '615-555-7171', 9),
('Mary', 'Mariam', 'marymary@gmail.com', '615-555-7777', 9),
('Franky', 'Frankson', 'frankyfrank@gmail.com', '615-555-3232', 9);

	
SELECT * FROM employees ORDER BY employee_type_id DESC;


SELECT * FROM dealerships
WHERE business_name LIKE 'Sollow%' OR business_name LIKE 'Hrishche%' OR business_name LIKE 'Cadrema%';

SELECT * FROM employees ORDER BY employee_id DESC;

INSERT INTO dealershipemployees(dealership_id, employee_id)
VALUES
(50,1001),
(128,1001),
(322,1001),
(50,1002),
(128,1002),
(322,1002),
(50,1003),
(128,1003),
(322,1003),
(50,1004),
(128,1004),
(322,1004),
(50,1005),
(128,1005),
(322,1005);




SELECT MAX(dealership_employee_id) FROM dealershipemployees;   
SELECT nextval('dealership_employee_id');

SELECT setval('the_primary_key_sequence', (SELECT MAX(dealership_employee_id) FROM dealershipemployees)+1);


SELECT * FROM dealershipemployees
ORDER BY employee_id DESC;

SELECT * FROM dealershipemployees
ORDER BY dealership_id DESC;

SELECT * FROM dealershipemployees
WHERE employee_id = 1001;

SELECT * FROM dealershipemployees
WHERE employee_id = 1002;

SELECT * FROM dealershipemployees
WHERE employee_id = 322;


ROLLBACK;

COMMIT;


-- #2 Create a transaction for:
-- Creating a new dealership in Washington, D.C. called Felphun Automotive
-- Hire 3 new employees for the new dealership: Sales Manager, General Manager and Customer Service.
-- All employees that currently work at Scrogges Autos of District of Columbia will now start working at Felphun Automotive instead.


BEGIN;

SELECT * FROM dealerships;

-- Creating a new dealership in Washington, D.C. called Felphun Automotive
INSERT INTO public.dealerships(business_name)
	VALUES ('Felphun Automotive');
	
--note dealership_id for Flephun is 1012
SELECT * FROM dealerships
WHERE business_name LIKE 'Felphun%';

-- Hire 3 new employees for the new dealership: Sales Manager employee_type_id (3), General Manager employee_type_id (6) and Customer Service employee_type_id (4).

-- see what types we have
SELECT * FROM employeetypes;

INSERT INTO employees(
first_name, last_name, email_address, phone, employee_type_id)
VALUES 
('Sally', 'Sellsabunch', 'sally101@gmail.com', '615-555-1515', 3),
('Frank', 'Sitsonhisrear', 'frankdontworkmuch@gmail.com', '615-555-9933', 6),
('Carl', 'Nicephonevoice', 'carlisnice500@gmail.com', '615-555-7788', 4);

SELECT * FROM employees;

-- All employees that currently work at Scrogges Autos of District of Columbia will now start working at Felphun Automotive instead.
--employees with their employee_id need to be added to new dealership >> sally 1012, frank 1013, carl 1014 

-- find dealership_id = 129
SELECT * FROM dealerships
WHERE business_name LIKE'Scrogges%';


SELECT * FROM dealershipemployees
WHERE dealership_id = 129;


  
  -- need to move all employees from dealership with 129 to 1009 for Felphun Automotive in the dealershipemployees table 
  -- this uses an UPDATE
  
SELECT * FROM dealershipemployees de
WHERE de.dealership_id = 129;
  
  --violates foreign key constraint "dealershipemployees_dealership_id_fkey"
  -- we must remove the constraint BEFORE doing the UPDATE and then restore the constraint AFTER the UPDATE
  
ALTER TABLE dealershipemployees
DROP CONSTRAINT dealershipemployees_dealership_id_fkey;

  
UPDATE dealershipemployees de
SET dealership_id = 1011

WHERE de.dealership_id = 129;
-- WHERE dealership_employee_id = 98;





SELECT * FROM dealershipemployees
WHERE dealership_id = 1011;

-- and need to insert 3 new rows into  dealershipemployees for the new hires to be linked to the right dealership
  -- this uses and INSERT
  
SELECT * FROM employees
ORDER BY employee_id DESC;
  
  
INSERT INTO public.dealershipemployees(employee_id, dealership_id)

	VALUES 
	('1030', '1009'),
	('1031', '1009'),
	('1032', '1009');



ALTER TABLE dealershipemployees
ADD CONSTRAINT dealershipemployees_dealership_id_fkey
FOREIGN KEY (dealership_id) REFERENCES dealershipemployees(dealership_id) ON DELETE CASCADE;



ROLLBACK;



COMMIT;
	

