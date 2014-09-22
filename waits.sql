col event form A50 
col Prev form 999 
col Curr form 999 
col Tot form 999 
select 
event,
sum(decode(wait_Time,0,0,1)) "Prev", 
sum(decode(wait_Time,0,1,0)) "Curr",
count(*) "Tot" 
from 
v$session_Wait 
group by event 
order by 4
/
