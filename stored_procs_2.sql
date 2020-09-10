-- Selling a Vehicle
-- Carnival would like to create a stored procedure that handles the case of updating their 
-- vehicle inventory when a sale occurs. They plan to do this by flagging the vehicle as is_sold which is a field on the Vehicles table. When set to True this flag will indicate that the vehicle is no longer available in the inventory. Why not delete this vehicle? We don't want to delete it because it is attached to a sales record.

-- a.	Need to add is_sold BOOL to the vehicles table – using an alter???
-- b.	Create a procedure that puts True flag into the is_sold field base on vehicle_id
-- c.	Check the vehicle table using select to verify the is_sold flag is present 

-- Need to add is_sold BOOL to the vehicles table – using an alter???

ALTER TABLE vehicles 
ADD COLUMN is_sold BOOL;

SELECT * 
FROM vehicles;


-- Create a procedure that puts True flag into the is_sold field base on vehicle_id
-- 

DROP PROCEDURE sold(integer)

create or replace procedure sold(
   v_id int

)
language plpgsql    
as $$
begin
    -- setting the is_sold to TRUE in the vehicle 
    update vehicles 
    set is_sold = 'TRUE' 
    where vehicle_id = v_id;

    commit;
end;$$

-- The below statement invokes the sold stored procedure to mark is_sold TRUE:
call sold(6);

SELECT * FROM vehicles
WHERE is_sold = 'TRUE'




