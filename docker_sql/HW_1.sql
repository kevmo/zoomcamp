-- SQL Queries from HW questions 3-6.  The docker commands were just run in a terminal.

-- Question 3: Trips started and completed on Jan 15 = 20530

SELECT COUNT(*) 
FROM green_taxi g 
WHERE
    DATE_TRUNC('DAY', g.lpep_pickup_datetime) = DATE_TRUNC('DAY', TIMESTAMP '2019-01-15')
AND
    DATE_TRUNC('DAY', g.lpep_dropoff_datetime) = DATE_TRUNC('DAY', TIMESTAMP '2019-01-15');


-- Question 4: Day with longest trip distance (using pickup time)

SELECT 
	lpep_pickup_datetime,
	trip_distance
FROM green_taxi
ORDER BY trip_distance 
DESC LIMIT 1;

-- Question 5: Passenger counts of 2 & 3 on 2019-01-01 [USING PICKUP TIME] = 1282 & 254

SELECT COUNT(*) 
FROM green_taxi g 
WHERE
DATE_TRUNC('DAY', g.lpep_pickup_datetime) = DATE_TRUNC('DAY', TIMESTAMP '2019-01-01')
AND passenger_count = 3;


-- Question 6: Biggest tip from a ride originating in Astoria = LI City/Queens Plaza

-- dumb way
SELECT *
FROM green_taxi g
WHERE
	g."PULocationID" = 7
ORDER BY tip_amount DESC;
-- 146 = 

-- smarter way

SELECT z."Zone"
FROM zones z
JOIN 
    (SELECT *
    FROM green_taxi g
    WHERE
        g."PULocationID" = 7
    ORDER BY tip_amount DESC
    LIMIT 1
    ) as trips
ON z."LocationID" = trips."DOLocationID";



--- notes 

-- question 4 misinterpreted

SELECT  
	CAST(lpep_pickup_datetime AS DATE) AS "day",
	sum(trip_distance)
FROM green_taxi 
GROUP BY 
	CAST(lpep_pickup_datetime AS DATE)
ORDER BY 2 DESC;



-- dumb join
SELECT 
	lpep_pickup_datetime,
	lpep_dropoff_datetime,
	total_amount,
	CONCAT(lpu."Borough", ' / ', lpu."Zone") AS "pickup_loc",
	CONCAT(ldo."Borough", ' / ', ldo."Zone") AS "dropoff_loc"
from 
	green_taxi g,
	zones lpu,
	zones ldo
where 
	g."PULocationID" = lpu."LocationID" AND
	g."DOLocationID" = ldo."LocationID";


-- smarter - use join
SELECT 
	lpep_pickup_datetime,
	lpep_dropoff_datetime,
	total_amount,
	CONCAT(lpu."Borough", ' / ', lpu."Zone") AS "pickup_loc",
	CONCAT(ldo."Borough", ' / ', ldo."Zone") AS "dropoff_loc"
from 
	green_taxi g JOIN zones lpu
	ON g."PULocationID" = lpu."LocationID"
	JOIN zones ldo ON g."DOLocationID" = ldo."LocationID";
