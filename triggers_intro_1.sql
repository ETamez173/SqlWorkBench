
--create a trigger that will set the pickup date of the vehicle to be seven days
--from the date of purchase every time a new row is added to the Sales table.

CREATE FUNCTION set_pickup_date() 
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$
BEGIN
  -- trigger function logic
  UPDATE sales
  SET pickup_date = NEW.purchase_date + integer '7'
--    SET pickup_date = NEW.purchase_date + 7
--     SET pickup_date = NEW.purchase_date + 1 month
  WHERE sales.sale_id = NEW.sale_id;
  
  RETURN NULL;
END;
$$


CREATE TRIGGER new_sale_made
  AFTER INSERT
  ON sales
  FOR EACH ROW
  EXECUTE PROCEDURE set_pickup_date();
  
  
  DROP FUNCTION set_pickup_date
  DROP TRIGGER new_sale_made
  
  
  INSERT INTO sales(sales_type_id, vehicle_id, employee_id, dealership_id, price, invoice_number, purchase_date)
  VALUES (1,11,111,111,10111,101010101, CURRENT_DATE);
  
  SELECT * FROM sales
  ORDER BY sale_id DESC;
  
  
--   Practice: Carnival

-- #1 Create a trigger for when a new Sales record is added, set the purchase date to 3 days from the current date.

CREATE OR REPLACE FUNCTION set_purchase_date()
   RETURNS TRIGGER
   LANGUAGE PLPGSQL
AS $$
   BEGIN
   UPDATE sales
   SET purchase_date = CURRENT_DATE + 3
   WHERE sales.sale_id = NEW.sale_id;
   RETURN NULL;
END;
$$

CREATE TRIGGER new_sale_added
AFTER INSERT
ON sales
FOR EACH ROW
EXECUTE PROCEDURE set_purchase_date();


DROP TRIGGER new_sale_added
ON sales;
  

INSERT INTO sales(sales_type_id, vehicle_id, employee_id, dealership_id, price, invoice_number, purchase_date)
VALUES (1,11,111,111,10111,101010101,CURRENT_DATE);
  
SELECT * FROM sales
ORDER BY sale_id DESC;


-- #2 Create a trigger for updates to the Sales table. 
--  a) If the pickup date is on or before the purchase date, set the pickup date to 7 days after the purchase date.
--  b) If the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional days to the pickup date.
  
CREATE OR REPLACE FUNCTION conditionally_set_pickup_date()
  		RETURNS TRIGGER
 		LANGUAGE plpgsql
AS $$
BEGIN
  		IF NEW.pickup_date <= NEW.purchase_date THEN
  			UPDATE sales
			SET pickup_date = NEW.purchase_date + 7
			WHERE sales.sale_id = NEW.sale_id;
  		ELSIF NEW.pickup_date > NEW.purchase_date AND NEW.pickup_date < NEW.purchase_date +7 THEN
			UPDATE sales
			SET pickup_date = NEW.pickup_date + 4
			WHERE sales.sale_id = NEW.sale_id;
 		END IF;
  
  RETURN NULL;
  
END;
$$
  
  DROP TRIGGER update_sale_made_pickup_date ON sales;
  
  CREATE TRIGGER update_sale_made_pickup_date
  AFTER UPDATE
  ON sales
  FOR EACH ROW EXECUTE PROCEDURE conditionally_set_pickup_date();
  
  
  UPDATE sales
  SET pickup_date = CURRENT_DATE
  WHERE sale_id =1012;
  
  
  SELECT * FROM sales
  ORDER BY sale_id DESC;
  
  
  --ALTERNATIVE 
  
CREATE OR REPLACE FUNCTION conditionally_set_pickup_date()
  	RETURNS TRIGGER
 	LANGUAGE plpgsql
AS $$
BEGIN
  	IF NEW.pickup_date > NEW.purchase_date AND NEW.pickup_date <= NEW.purchase_date + integer '7' THEN
	  NEW.pickup_date := NEW.pickup_date + integer '4';	
	ELSIF NEW.pickup_date <= NEW.purchase_date THEN
	  NEW.pickup_date := NEW.purchase_date + integer '7';
	END IF;
			  
  RETURN NEW;
  
END;
$$
  
  DROP TRIGGER update_sale_made_pickup_date ON sales;
  
CREATE TRIGGER update_sale_made_pickup_date
    BEFORE UPDATE
    ON sales
    FOR EACH ROW 
	EXECUTE PROCEDURE conditionally_set_pickup_date();
  
  
UPDATE sales
SET pickup_date = purchase_date + 1
WHERE sale_id > 1000;
  
  
SELECT * FROM sales
ORDER BY sale_id DESC;
  
  -- 36 min point on 091120 ZOOM meeting there is a recap 
  
  -- 44 min point on 091120 ZOOM meeting website URL excercise begins
  -- time to finish STORED PROCS 
  -- 1 hr 2  Chapter 7 TRANSACTIONS for TUES is assigned
  