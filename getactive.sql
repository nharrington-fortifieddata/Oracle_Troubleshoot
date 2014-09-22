set lines 180 pages 1000 echo off
col machine for a30
col osuser for a15
col username for a20
col program for a25
col sidserial for a10
col last_call for a15
select a.sid || ',' || a.serial# as sidserial
,       b.spid
,       to_char(a.logon_time,'MMDD HH24:MI') logontime
,	(case  
	when a.last_call_et < 60 then a.last_call_et || ' Secs'
        when a.last_call_et between 60 and 3599 then round(a.last_call_et/60,2) || ' Mins'
        else round(a.last_call_et/60/60,2) || ' Hrs' end) last_call
,       a.username
,	a.osuser
,       substr(a.machine,1,30) as machine
,       a.status
,	substr(a.program,1,25) as program
from v$session a 
join v$process b
on a.paddr = b.addr 
and a.username is not null
and status = 'ACTIVE'
order by last_call_et desc , logon_time
/
