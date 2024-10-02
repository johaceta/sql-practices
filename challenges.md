check if a string neither starts nor ends with a vowel

1.
select distinct CITY
from STATION
where CITY not like '[aeiouAEIOU]%'
and CITY not like '%[aeiouAEIOU]'

2.
select distinct CITY
from STATION
where LEFT(lower(CITY),1) not in  ('a','e','i','o','u')
and RIGHT(lower(CITY),1) not in  ('a','e','i','o','u')

Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID

Select Name
from students
where marks > 75
order by RIGHT(Name,3), ID

Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to  decimal places.

SELECT CAST(SUM(LAT_N) AS DECIMAL(18, 4)) AS NorthernLat
FROM station 
WHERE LAT_N BETWEEN 38.7880 AND 137.2345 ;

Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to  decimal places.

1. select cast(max(LAT_N) as DECIMAL(18,4))NorthernLat
from station
where LAT_N <137.2345

2. select TOP 1 cast((LAT_N) as DECIMAL(18,4))NorthernLat
from station
where LAT_N <137.2345
ORDER BY LAT_N DESC

