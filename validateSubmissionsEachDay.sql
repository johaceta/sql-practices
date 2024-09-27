/*
Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest), 
and find the hacker_id and name of the hacker who made maximum number of submissions each day. 
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id.

*/

with dailySubs as (
Select s.submission_date, h.hacker_id,h.name, count(1) as subs, 
    DENSE_RANK() over (partition by submission_date order by count(1) desc, h.hacker_id) as ranked
from Hackers h
inner join Submissions s
on h.hacker_id = s.hacker_id
where s.submission_date between '2016-03-01' and '2016-03-16'
group by s.submission_date, h.hacker_id,h.name    
), hackerDaySequence as (
Select submission_date ,hacker_id, dense_rank() over(order by submission_date) rnkDaySequence
    from dailySubs
    group by submission_date ,hacker_id
), prevsubmissions as (Select hds.submission_date, hds.hacker_id ,hds.rnkDaySequence
, case when hds.submission_date ='2016-03-01' then 1
else 1+(select count(distinct a.submission_date) from dailySubs a 
        where a.hacker_id = hds.hacker_id and a.submission_date< hds.submission_date
       ) end prevsub
from hackerDaySequence hds ),
eachday_counthacker  as (
Select submission_date, count(distinct hacker_id) as distHackers
from prevsubmissions
where rnkDaySequence = prevsub
group by submission_date
)
Select a.submission_date, b.distHackers, a.hacker_id,a.name
from dailySubs a 
inner join eachday_counthacker b on a.submission_date = b.submission_date
where ranked=1
