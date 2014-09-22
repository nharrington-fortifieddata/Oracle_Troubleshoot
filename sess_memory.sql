column name format a25
column total format 999 heading 'Cnt'
column bytes format 9999,999,999 heading 'Total Bytes'
column avg format 99,999,999 heading 'Avg Bytes'
column min format 99,999,999 heading 'Min Bytes'
column max format 9999,999,999 heading 'Max Bytes'
ttitle 'PGA = dedicated server processes - UGA = Client machine process'


compute sum of minmem on report
compute sum of maxmem on report
break on report

select se.sid,n.name, 
max(se.value) maxmem
from v$sesstat se,
v$statname n
where n.statistic# = se.statistic#
and n.name in ('session pga memory','session pga memory max',
'session uga memory','session uga memory max')
group by n.name,se.sid
order by 3
/

