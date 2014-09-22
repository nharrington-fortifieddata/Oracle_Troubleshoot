--**************************************************************
--   session.sql
--
--   © 2002 by Donald K. Burleson
--
--   No part of this SQL script may be copied, sold or distributed
--   without the express consent of Donald K. Burleson
--**************************************************************
rem session.sql - displays all connected sessions
set echo off;
set termout on;
set linesize 80;
set pagesize 60;
set newpage 0;

select
   rpad(c.name||':',11)||rpad(' current logons='||
   (to_number(b.sessions_current)),20)||'cumulative logons='||
   rpad(substr(a.value,1,10),10)||'highwater mark='||
   b.sessions_highwater Information
from
   v$sysstat a, 
   v$license b, 
   v$database c 
where 
   a.name = 'logons cumulative'
;

ttitle "dbname Database|UNIX/Oracle Sessions";

set heading off;
select 'Sessions on database '||substr(name,1,8) from v$database;
set heading on;
select
       substr(a.spid,1,9)      pid,
       substr(b.sid,1,5)       sid,
       substr(b.serial#,1,5)   ser#,
       substr(b.machine,1,6)   box,
       substr(b.username,1,10) username,
       substr(b.osuser,1,8)    os_user,
       substr(b.program,1,30)  program
from 
   v$session b, 
   v$process a
where
   b.paddr = a.addr
and 
   type='USER'
order by 
   spid
;


ttitle off;
set heading off;
select 'To kill, enter SQLPLUS>  ALTER SYSTEM KILL SESSION',
''''||'SID, SER#'||''''||';' from dual;
spool off;

