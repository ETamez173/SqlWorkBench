-- Selling a Vehicle
-- Carnival would like to create a stored procedure that handles the case of updating their 
-- vehicle inventory when a sale occurs. They plan to do this by flagging the vehicle as is_sold which is a field on the Vehicles table. When set to True this flag will indicate that the vehicle is no longer available in the inventory. Why not delete this vehicle? We don't want to delete it because it is attached to a sales record.

-- a.	Need to add is_sold BOOL to the vehicles table – using an alter???
-- b.	Create a procedure that puts True flag into the is_sold field base on vehicle_id
-- c.	Check the vehicle table using select to verify the is_sold flag is present 

-- Need to add is_sold BOOL to the vehicles table – using an alter???
BEGIN;

--  cannot drop table vehicles because => constraint sales_vehicle_id_fkey on table sales depends on table vehicles
DROP TABLE vehicles


-- this is the correct ALTER command 
ALTER TABLE vehicles 
ADD COLUMN is_sold BOOL NOT NULL
SET DEFAULT false;

SELECT * 
FROM vehicles;

ROLLBACK;

-- attempt to set BOOL to false or true in all rows 
BEGIN;

SELECT * FROM vehicles;

-- just to set all as sold - true or not sold - false
UPDATE vehicles
SET is_sold = true;

ROLLBACK;


-- Selling a vehicle
-- Create a procedure that puts True flag into the is_sold field base on vehicle_id
-- 
CREATE PROCEDURE remove_vehicle_from_inventory(vehicleId int)
LANGUAGE plpgsql
AS $$
BEGIN

UPDATE vehicles v
SET is_sold = true
WHERE v.vehicle_id = vehicleId; 

END
$$;

CALL remove_vehicle_from_inventory(2);
CALL remove_vehicle_from_inventory(3);
CALL remove_vehicle_from_inventory(22);

SELECT * FROM vehicles
WHERE vehicle_id = 2;

-- Returning a Vehicle

-- Carnival would also like to handle the case for when a car gets returned by a customer. 
-- When this occurs they must add the car back to the inventory and mark the original sales record as returned = True.

-- Carnival staff are required to do an oil change on the returned car before putting it back on the sales floor. 
-- In our stored procedure, we must also log the oil change within the OilChangeLog table.


-- a.	Need to add returned BOOL to the sales table – using an alter 
BEGIN;

ALTER TABLE sales
ADD COLUMN sale_returned BOOL
DEFAULT false;

SELECT * FROM sales
ORDER BY sale_id;


SELECT * FROM vehicles
ORDER BY vehicle_id;

ROLLBACK;

-- b.	Need to add oilchangelogs table using create table

CREATE TABLE oilchangelogs (
oil_change_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
date_of_service timestamp with time zone,
vehicle_id int,
FOREIGN KEY (vehicle_id) REFERENCES Vehicles (vehicle_id)
);

-- c.	Create a procedure for vehicles table that puts False flag into the is_sold field based on vehicle_id
-- AND that puts True flag into the sale_returned field based on vehicle_id

CREATE OR REPLACE PROCEDURE return_sold_vehicle(in vehicleId int)
LANGUAGE plpgsql
AS $$
BEGIN

	UPDATE sales
	SET sale_returned = true
	WHERE vehicle_id = vehicleId;

	UPDATE vehicles
	SET is_sold = false
	WHERE vehicle_id = vehicleId; 

	INSERT INTO oilchangelogs(date_of_service, vehicle_id)
	VALUES (CURRENT_DATE, vehicleId);

END
$$;

DROP PROCEDURE return_sold_vehicle(vehicleId int);


CALL return_sold_vehicle(10);

SELECT * FROM vehicles
WHERE vehicle_id = 10;

SELECT * FROM vehicles
ORDER BY vehicle_id;


SELECT * FROM sales
ORDER BY vehicle_id;

SELECT * FROM sales
WHERE vehicle_id = 10;

END
$$;

SELECT v.vehicle_id, v.vin, s.sale_returned, v.is_sold, o.date_of_service FROM vehicles v
LEFT JOIN sales s ON v.vehicle_id = s.vehicle_id
LEFT JOIN oilchangelogs o ON v.vehicle_id = o.vehicle_id
WHERE v.vehicle_id = 10;

--- still having problem with the UPDATE to sales to make the sale_returned TRUE????