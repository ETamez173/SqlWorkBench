-- Carnival Dealerships

-- Because Carnival is a single company, we want to ensure that there is consistency in the data provided to the user. 
-- Each dealership has it's own website but we want to make sure the website URL are consistent and easy to remember. 


-- a) Therefore, any time a new dealership is added or an existing dealership is updated, we want to ensure that the website URL 
-- has the following format: http://www.carnivalcars.com/{name of the dealership with underscores separating words}.

CREATE OR REPLACE FUNCTION format_dealership_website()
  	RETURNS TRIGGER
 	LANGUAGE plpgsql
AS $$
BEGIN
-- 	NEW.website := CONCAT('http://www.carnivalcars.com/', REGEXP_REPLACE(LOWER(NEW.business_name), '( ){1,}', '_', 'g'));
	NEW.website := CONCAT('http://www.carnivalcars.com/', REPLACE(LOWER(NEW.business_name), ' ', '_'));
-- 	REGEXP_REPLACE('This   is    string', {2,}, '')
  	RETURN NEW;
	
END;
$$

DROP TRIGGER dealership_website ON dealerships;

CREATE TRIGGER dealership_website 
BEFORE INSERT OR UPDATE          
ON dealerships
FOR EACH ROW EXECUTE PROCEDURE format_dealership_website();

INSERT INTO dealerships(business_name, phone, city, state, website, tax_id)
VALUES ('Newwest Dealership in Music City', '615-300-3000', 'Nashville', 'Tennessee', 'www.test.com', 'ab-300-3000');



SELECT * FROM dealerships ORDER BY dealership_id DESC;


-- b) If a phone number is not provided for a new dealership, set the phone number to the default customer care number 777-111-0305.




-- c) For accounting purposes, the name of the state needs to be part of the dealership's tax id. For example, if the tax id provided 
-- is bv-832-2h-se8w for a dealership in Virginia, then it needs to be put into the database as bv-832-2h-se8w--virginia.