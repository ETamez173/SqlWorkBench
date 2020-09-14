--SELECT * FROM public.customers

--SELECT COUNT(*) FROM public.customers

--SELECT last_name, phone, state FROM public.customers

--SELECT * 
--FROM public.customers
--WHERE state != 'OH'

SELECT * 
FROM public.vehicles
-- WHERE year_of_car >= '2016' AND year_of_car <= '2019'
-- ORDER BY floor_price ASC
-- LIMIT 1

-- SELECT * FROM vehicles

-- SELECT v.engine_type,
-- 		v.floor_price,
-- 		v.msr_price
-- FROM vehicles v

--Write a query that returns the business name, city, state, and website for each dealership. Use an alias for the Dealerships table.
SELECT business_name,
		city,
		state,
		website
FROM dealerships as "Dealer";

--Write a query that returns the first name, last name, and email address of every customer. Use an alias for the Customers table.
SELECT
		c.first_name,
		c.last_name,
		c.email
FROM customers c
		

