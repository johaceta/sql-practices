SET NOCOUNT ON;


/*
Order a concat column by other column
*/

go
with totalTraffic as (
Select client, protocol, sum(traffic_in + traffic_out) totaltraffic
from traffic
group by  client, protocol
)
,
SortedProtocols as (
select client, protocol, totaltraffic,
row_number() over (partition by client order by totalTraffic desc) as sorted
from totalTraffic    
)
Select client, string_agg(protocol,',') WITHIN GROUP (order by totaltraffic desc) as groupedprotocol
from SortedProtocols
group by client
order by client asc ;
