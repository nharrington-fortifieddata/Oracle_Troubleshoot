set lines 170
select /*+ use_hash(a b c) */
	a.SID 
       	,b.username 
       	,a.SEQ# 
       	,a.EVENT 
       	,a.WAIT_TIME 
       	,a.SECONDS_IN_WAIT 
       	,a.STATE 
       	,a.P1TEXT || ':' || a.P1 as P1
       	,a.P2TEXT || ':' || a.P2 as P2 
       	,a.P3TEXT || ':' || a.P3 as P3 
       	,c.address
       	,c.sql_text 
       	,'====================================================================================================' as final_col
  from v$session_wait a,
       v$session b,
       v$sql c
 where a.event not like '%message%'
   and a.event not like '%smon%'
   and a.event not like '%pmon%'
   and a.event not like '%time%'
   and a.sid = b.sid
   and b.sql_address = c.address (+)
   and b.sql_hash_value = c.hash_value (+)
order by b.username;
