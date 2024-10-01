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
