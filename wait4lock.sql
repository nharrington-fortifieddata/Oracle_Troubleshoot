set lines 120 echo off
select event,p1,p2,p3 
from v$session_wait 
where wait_time=0 
and event='enqueue'
;

set echo on

