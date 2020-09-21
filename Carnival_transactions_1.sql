-- Goals
-- Using CREATE to add new tables
-- Using triggers
-- Using stored procedures
-- Using transactions

-- Practice
--#1 Provide a way for the accounting team to track all financial transactions by creating a new table called Accounts Receivable. 
-- The table should have the following columns: credit_amount, debit_amount, date_received as well as a PK and a FK to associate a sale with each transaction.

-- Set up a trigger on the Sales table. When a new row is added, add a new record to the Accounts Receivable table with the deposit as credit_amount, 
-- the timestamp as date_received and the appropriate sale_id.

--#2 Set up a trigger on the Sales table for when the sale_returned flag is updated. Add a new row to the Accounts Receivable table with the deposit as 
-- debit_amount, the timestamp as date_received, etc.

-- Practice
-- Help out HR fast track turnover by providing the following:

-- Create a stored procedure with a transaction to handle hiring a new employee. Add a new record for the employee in the Employees table and add a record 
-- to the Dealershipemployees table for the two dealerships the new employee will start at.

-- Create a stored procedure with a transaction to handle an employee leaving. The employee record is removed and all records associating the employee 
-- with dealerships must also be removed.


-- need to add BOOL to sales not vehicle
BEGIN;

ALTER TABLE sales
ADD COLUMN sale_returned BOOL
DEFAULT FALSE;

SELECT * FROM sales;

ROLLBACK;



DROP table accounts_recievable;

CREATE table accounts_recievable(
	accounts_receivable_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	credit_amount decimal,
	debit_amount decimal, 
	date_received timestamp,
	sale_id int,
	PRIMARY KEY (accounts_receivable_id),
	FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);

select * from accounts_recievable;

-- Set up a trigger on the Sales table. When a new row is added, add a new record to the Accounts Receivable table with the deposit as credit_amount, 
-- the timestamp as date_received and the appropriate sale_id.


BEGIN;

CREATE OR REPLACE FUNCTION add_accounts_receivable()
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $$
BEGIN
-- trigger logic
 INSERT INTO accounts_receivable(sale_id, credit_amount, date_received)
 VALUES(NEW.sale_id, NEW.deposit, CURRENT_TIMESTAMP);
 
 RETURN NULL;

END;

$$




CREATE TRIGGER new_deposit_made
  AFTER INSERT
  ON sales
  FOR EACH ROW
  EXECUTE PROCEDURE EXECUTE PROCEDURE add_accounts_receivable();
  
  
  NSERT INTO public.sales(
    sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method)
    VALUES (1, 5, 5, 5, 5, 5, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 'mastercard');


ROllBACK;





	
	
	-- BILLY Sent this
	
	--Provide a way for the accounting team to track all financial
--transactions by creating a new table called Accounts Receivable.
--The table should have the following columns: credit_amount,
--debit_amount, date_received as well as a PK and a FK to 
--associate a sale with each transaction.
CREATE TABLE accounts_receivable(
    accounts_receivable_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    credit_amount decimal,
    debit_amount decimal,
    date_received timestamp,
    sale_id int,
    PRIMARY KEY (accounts_receivable_id),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);
--Set up a trigger on the Sales table. When a new row is added,
--add a new record to the Accounts Receivable table with the
--deposit as credit_amount, the timestamp as date_received
--and the appropriate sale_id.
CREATE OR REPLACE FUNCTION add_accounts_receivable() 
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$
BEGIN
  -- trigger function logic
  INSERT INTO accounts_receivable(sale_id, credit_amount, date_received)
  VALUES(NEW.sale_id, NEW.deposit, CURRENT_TIMESTAMP);
  RETURN NULL;
END;
$$;
$$ CREATE TRIGGER new_deposit_made
AFTER
INSERT
    ON sales FOR EACH ROW EXECUTE PROCEDURE add_accounts_receivable();
INSERT INTO public.sales(
    sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method)
    VALUES (1, 5, 5, 5, 5, 5, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 'mastercard');
