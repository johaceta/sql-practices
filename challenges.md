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
