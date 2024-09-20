SET NOCOUNT ON;

/*
Enter your query below.
Please append a semicolon ";" at the end of the query
*/
go
SELECT algorithm
, Q1
, Q2
, Q3
, Q4
FROM
(SELECT a.algorithm
, Concat('Q', datepart(QUARTER,b.dt)) AS Quarterly
, sum(b.volume)  as suma
FROM coins a 
inner join transactions b
on a.code = b.coin_code
where year(b.dt)=2020
group by a.algorithm, Concat('Q', datepart(QUARTER,b.dt)) ) as src
PIVOT
(
    SUM(suma)
    FOR Quarterly IN ([Q1],[Q2],[Q3],[Q4])
) as pivoting
