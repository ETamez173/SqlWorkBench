-- Practice: Employees

--#1 Rheta Raymen an employee of Carnival has asked to be transferred to a different dealership location. 
-- She is currently at dealership 751. She would like to work at dealership 20. Update her record to reflect her transfer.

SELECT * 
FROM dealershipemployees
WHERE dealership_id = 20;


SELECT * 
FROM dealershipemployees
WHERE employee_id = 680;
-- dont update the 154 dealership_id = 154 ONLY the one that has 751

-- to see what Rhetas employee_id is and its 680
SELECT * 
FROM employees
WHERE first_name LIKE '%Rheta%';

-- this does the update and is set to ONLY change the correct dealership_id that meets both criteria
UPDATE dealershipemployees 
SET dealership_id = 20
WHERE employee_id = 680 AND dealership_id = 751;



-- to see all the dealership_id 
SELECT *
FROM Dealershipemployees;


-- when you run this you find that Rheta works at two locations 751 and 154 before the UPDATE
-- so to update ONLY the 751 location you need to use the de.employee_id
SELECT *, d.dealership_id
FROM employees e
JOIN dealershipemployees de ON de.employee_id = e.employee_id
JOIN dealerships d ON d.dealership_id = de.dealership_id
WHERE e.last_name = 'Raymen';

--#2 Practice: Sales 
-- A Sales associate needs to update a sales record because her customer wants to pay wish Mastercard instead of American Express. 
-- Update Customer, Layla Igglesden Sales record which has an invoice number of 2781047589.

-- just to see the record before the change
SELECT s.invoice_number, c.first_name, c.last_name, s.invoice_number, s.payment_method
FROM sales s
JOIN customers c ON c.customer_id = s.customer_id
WHERE s.invoice_number = '2781047589';

-- now the update
UPDATE sales s
SET payment_method = 'Mastercard'
WHERE s.invoice_number = '2781047589';

--NOTE to self the syntax is very sensitive regarding using double quotes "" vs single quotes '' etc

test

SELECT * FROM sales s
WHERE s.customer_id = 13;


-- Practice - Employees / Deleting Data

-- #1 A sales employee at carnival creates a new sales record for a sale they are trying to close. The customer, last minute decided not to purchase the vehicle. 
-- Help delete the Sales record with an invoice number of '7628231837'.


select * from sales s
where invoice_number = '2781047589';

-- be careful make sure to use a conditional OR you will delete all records ---- BAD!!
delete from sales
where invoice_number = '2781047589';


-- #2 An employee was recently fired so we must delete them from our database. Delete the employee with employee_id of 35.
-- What problems might you run into when deleting? How would you recommend fixing it?

select * from employees e
where e.employee_id = 35;

-- this attempt violates foreign key constraint "sales_employee_id_fkey" on table "sales"
delete from employees
where employee_id = 35;

SELECT * FROM employees
WHERE employee_id = 35;

-- Solutions to the DELETE needed
-- option 1 - delete all things that reference this employee records -like sales reference and dealershipemployees table before
-- this delete would work 

BEGIN;

-- doing it this way we lose the sales record and that may be needed 
DELETE FROM sales WHERE employee_id = 35;

DELETE FROM employees WHERE employee_id = 35;

-- tests
SELECT * FROM sales s WHERE s.employee_id = 35;

SELECT * FROM employees WHERE employee_id = 35;

-- does not effect dealershipemployees join table
SELECT * FROM dealershipemployees WHERE employee_id = 35;



ROLLBACK;


-- option 2 
-- if you want to keep the employee sales record - we pretend employee is not active employee
-- we are going to add a BOOL to employee table to indicate active or inactive - aka SOFT DELETE
BEGIN;

ALTER TABLE employees
ADD COLUMN isActive BOOL
DEFAULT TRUE;

SELECT * FROM employees;

UPDATE employees
SET isActive = true
WHERE employee_id = 35;

SELECT * FROM employees
WHERE employee_id = 35;

ROLLBACK;

-- option #3
-- this is an ON DELETE CASCADE

BEGIN;

-- the ALTER is on the sales table this time not the employee table
-- if we delete the employee record this will then result in the sales tied to that employee_id also being deleted

ALTER TABLE sales
DROP CONSTRAINT sales_employee_id_fkey,
ADD CONSTRAINT sales_employee_id_fkey
FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE;

-- can set the emplouyee_id to NULL  with ON DELETE NULL

Delete from employees
where empoyee_id = 35;

ROLLBACK;




