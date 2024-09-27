/*
 Write a query to print the hacker_id, name, and the total number of challenges created by each student.
Sort your results by the total number of challenges in descending order. If more than one student created
the same number of challenges, then sort the result by hacker_id. If more than one student created the same 
number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
*/
with cntChallengePerHacker as (
    Select hacker_id
        , count(challenge_id)  as cntChallenge
    from Challenges
    group by hacker_id
), rnkChallengePerHacker as ( 
    Select hacker_id 
    , cntChallenge
    , rank() over(order by cntChallenge) as rnkCntChallenge
    from cntChallengePerHacker 
), tempFinalTable as ( Select a.hacker_id 
    , b.name
    , a.cntChallenge
    , case when a.cntChallenge = a.maxCntChallenge then 1
        when a.cntChallenge < a.maxCntChallenge and a.cntHackers = 1 then 1
        else 0 end validHackerChallenge
    from (Select a.hacker_id 
        , a.cntChallenge
        , a.rnkCntChallenge
        , b.cntHackers
        , (select max(cntChallenge) maxCntChallenge
                   from rnkChallengePerHacker) maxCntChallenge
        from rnkChallengePerHacker a
        left join (select cntChallenge,rnkCntChallenge, count(hacker_id) cntHackers
                   from rnkChallengePerHacker
                   group by cntChallenge,rnkCntChallenge) b
        on a.cntChallenge = b.cntChallenge and a.rnkCntChallenge =b. rnkCntChallenge
        ) a 
    left join Hackers b on a.hacker_id = b.hacker_id
) Select hacker_id 
    , name
    , cntChallenge
from tempFinalTable
where validHackerChallenge = 1
order by cntChallenge desc

/*****option 2******/

SELECT c.hacker_id, h.name, count(c.challenge_id) AS cnt 
FROM Hackers AS h JOIN Challenges AS c ON h.hacker_id = c.hacker_id
GROUP BY c.hacker_id, h.name 
HAVING count(c.challenge_id) = (SELECT top 1 count(c1.challenge_id) FROM Challenges AS c1 GROUP BY c1.hacker_id 
              ORDER BY count(*) desc) or
count(c.challenge_id) NOT IN (SELECT count(c2.challenge_id) FROM Challenges AS c2 GROUP BY c2.hacker_id 
            HAVING c2.hacker_id <> c.hacker_id)
ORDER BY cnt DESC, c.hacker_id;
