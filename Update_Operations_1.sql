-- Practice: Employees

--#1 Rheta Raymen an employee of Carnival has asked to be transferred to a different dealership location. 
-- She is currently at dealership 751. She would like to work at dealership 20. Update her record to reflect her transfer.

UPDATE dealershipemployees 
SET dealership_id = 20
FROM dealershipemployees de 
WHERE de.dealership_employee_id = 10;

SELECT * 
FROM employees
WHERE first_name LIKE '%Rheta%';

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

--NOTE to self the syntaz is very sensitive regarding "" vs '' etc




