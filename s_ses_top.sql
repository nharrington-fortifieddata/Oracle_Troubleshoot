REM
REM DBAToolZ NOTE:
REM     This script was obtained from DBAToolZ.com
REM     It's configured to work with SQL Directory (SQLDIR).
REM     SQLDIR is a utility that allows easy organization and
REM     execution of SQL*Plus scripts using user-friendly menu.
REM     Visit DBAToolZ.com for more details and free SQL scripts.
REM
REM 
REM File:
REM     s_ses_top.sql
REM
REM <SQLDIR_GRP>USER STATS TRACE MOST</SQLDIR_GRP>
REM
REM SQLDIR Group Descriptions:
REM	APPS		-	APPS General
REM	APPS_INST	-	APPS Installation
REM	APPS_CONC_PROG	-	APPS Concurrent Programs
REM	APPS_CONC_MAN	-	APPS Concurrent Managers
REM	APPS_ADMIN	-	APPS Administration
REM	DBF		- 	Data Files
REM	TABSP		- 	Tablespace
REM	UTIL		- 	Utility
REM	INDX		- 	Index
REM	LOG		- 	Redo Log
REM	RBS		- 	Rollback
REM	MAINT		- 	Maintenance
REM	REVERSE		- 	Reverse Engineering
REM	SGA		- 	SGA Maintenance
REM	TAB		- 	Table
REM	USER		- 	User Management
REM	STATS		- 	Statistics
REM	STORAGE		- 	Storage Management
REM	INIT		- 	Database Init Parameters
REM	LATCH		- 	Latches
REM	LOCK		- 	Locks
REM	SEGMENT		- 	Segment Management
REM	BACKUP		- 	Backup Management
REM	PQ		- 	Parallel Query
REM	TRACE		- 	SQL Tracing Tuning
REM	PART		- 	Partitioning
REM	MOST		- 	Favorite Scripts
REM 
REM Author:
REM	Vitaliy Mogilevskiy vit100gain@earthlink.net
REM
REM
REM 
REM Purpose:
REM     <SQLDIR_TXT>
REM	This script lists top 10 sessions based
REM	on the following values from v$sesstat:
REM		- consistent gets
REM		- db block gets
REM		- physical reads
REM		- db block changes
REM     </SQLDIR_TXT>
REM
REM Usage:
REM     s_ses_top.sql
REM 
REM Example:
REM     s_ses_top.sql
REM
REM
REM History:
REM	03-20-2002	Vitaliy Mogilevskiy	Created
REM
REM


set lines 132
set trims on

col sid_serial        format a12         heading "Sid,Serial"
col USERNAME          format a8 trunc   heading "User"
col MACHINE           format a20 trunc   heading "Machine"
col OSUSER            format a10 trunc   heading "OS-User"
col logon             format a15         heading "Login Time"
col idle              format a8          heading "Idle"
col status            format a1          heading "S|t|a|t|u|s"
col lockwait          format a1          heading "L|o|c|k|w|a|i|t"
col module            format a35 trunc   heading "Module"                
                
select top_ten.tot_value
,      chr(39)||s.sid||','||s.serial#||chr(39) sid_serial
,      s.username
,      SUBSTR(s.status,1,1) status
,      s.lockwait
,      s.osuser
,      s.process
,      s.machine
,      to_char(s.logon_time,'DDth HH24:MI:SS') logon
,      floor(last_call_et/3600)||':'||
              floor(mod(last_call_et,3600)/60)||':'||
              mod(mod(last_call_et,3600),60)    IDLE
,      program||' '||s.module||' '||s.action  module
from 
   (select tot_value
    ,      sid
    from
	(select sum(stat.value) tot_value
        ,      s.sid
        from v$sesstat stat 
        ,    v$statname sname
		,    v$session s
        where s.sid = stat.sid
		and   stat.STATISTIC# = sname.STATISTIC#
        and   sname.name IN( 'consistent gets', 'db block gets'
                           , 'physical reads' , 'db block changes')
	and   s.type <> 'BACKGROUND'
	and   s.schemaname <> 'SYS'
	--and   s.status = 'ACTIVE'
        group by s.sid
        order by tot_value desc)
    where  rownum < 11)       top_ten
, v$session    s
where top_ten.sid = s.sid
order by 1 desc
/



