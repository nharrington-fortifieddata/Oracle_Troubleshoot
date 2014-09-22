REM
REM DBAToolZ NOTE:
REM	This script was obtained from DBAToolZ.com
REM	It's configured to work with SQL Directory (SQLDIR).
REM	SQLDIR is a utility that allows easy organization and
REM	execution of SQL*Plus scripts using user-friendly menu.
REM	Visit DBAToolZ.com for more details and free SQL scripts.
REM
REM 
REM File:
REM     s_user_sql.sql
REM
REM <SQLDIR_GRP>SGA USER TRACE MOST</SQLDIR_GRP>
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
REM	Vitaliy Mogilevskiy
REM
REM 
REM Purpose:
REM     <SQLDIR_TXT>
REM	This script reports SQL TEXT from v$sqltext
REM     </SQLDIR_TXT>
REM
REM Usage:
REM     s_user_sql.sql
REM 
REM Example:
REM     s_user_sql.sql
REM
REM
REM History:
REM	12-18-2001	Vitaliy Mogilevskiy	Created
REM
REM


set verify off

select sid, username, status from v$session
where username is not null and status = 'ACTIVE';
col sql_text format a80 word_wrapped

select sql_text
from v$sqltext
where address = (select sql_address from v$session where sid=&&sid)
and   hash_value = (select sql_hash_value from v$session where sid=&&sid)
order by piece

/


undefine sid



