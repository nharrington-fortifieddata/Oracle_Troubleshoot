set echo off
col username for a18
col program for a45

select
   s.sid,
   substr(s.username,1,18) username,
--   P.SPID,
   s.osuser as osuser,
   substr(s.program,1,45) program,
   decode(s.command
	,  1,'Create table' 
	,  2,'Insert'
	,  3,'Select' 
	,  6,'Update'
	,  7,'Delete' 
	,  9,'Create index'
	, 10,'Drop index' 
	, 11,'Alter index'
	, 12,'Drop table' 
	, 13,'Create seq'
	, 14,'Alter sequence' 
	, 15,'Alter table'
	, 16,'Drop sequ.' 
	, 17,'Grant'
	, 19,'Create syn.' 
	, 20,'Drop synonym'
	, 21,'Create view' 
	, 22,'Drop view'
	, 23,'Validate index' 
	, 24,'Create procedure'
	, 25,'Alter procedure' 
	, 26,'Lock table'
	, 42,'Alter session' 
	, 44,'Commit'
	, 45,'Rollback' 
	, 46,'Savepoint'
	, 47,'PL/SQL Exec' 
	, 48,'Set Transaction'
	, 60,'Alter trigger' 
	, 62,'Analyse Table'
	, 63,'Analyse index' 
	, 71,'Create Snapshot Log'
	, 72,'Alter Snapshot Log' 
	, 73,'Drop Snapshot Log'
	, 74,'Create Snapshot' 
	, 75,'Alter Snapshot'
	, 76,'drop Snapshot' 
	, 85,'Truncate table'
	,  0,'No command'
	, '? : '||s.command) command
from
   v$session     s,
   v$process     p,
   v$transaction t,
   v$rollstat    r,
   v$rollname    n
where s.paddr = p.addr
and   s.taddr = t.addr (+)
and   t.xidusn = r.usn (+)
and   r.usn = n.usn (+)
and s.command <> 0
order by 1;