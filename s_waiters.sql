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
REM     s_waiters.sql
REM
REM <SQLDIR_GRP>USER LOCK TRACE MOST</SQLDIR_GRP>
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
REM	This script reports sessions that are currently waiting
REM	output DECODED locking information from v$lock and v$sessions
REM     </SQLDIR_TXT>
REM
REM Usage:
REM     s_waiters.sql
REM 
REM Example:
REM     s_waiters.sql
REM
REM
REM History:
REM	12-18-2001	Vitaliy Mogilevskiy	Created
REM
REM


set lines 132
set trims on
col machine format a10

select       s.username
,            osuser
,            sid
,            decode(status,
                 'ACTIVE','Act',
               'INACTIVE','Inact',
                 'KILLED','Kill', status)      stat
,            decode(type,
           'BACKGROUND','Back',
                 'USER','User', type)          type
,          p.spid
,          s.terminal
,          s.machine
,          decode(command,
                       0,'',
                       1,'Create Table',
                       2,'Insert',
                       3,'Select',
                       4,'Create Clust',
                       5,'Alter Clustr',
                       6,'Update',
                       7,'Delete',
                       8,'Drop',
                       9,'Create Index',
                      10,'Drop Index',
                      11,'Alter Index',
                      12,'Drop Table',
                      15,'Alter Table',
                      17,'Grant',
                      18,'Revoke',
                      19,'Create Syn',
                      20,'Drop Synonym',
                      21,'Create View',
                      22,'Drop View',
                      26,'Lock Table',
                      27,'nop',
                      28,'Rename',
                      29,'Comment',
                      30,'Audit',
                      31,'Noaudit',
                      32,'Cre Ext Data',
                      33,'Drop Ext Dat',
                      34,'Create Data',
                      35,'Alter Data',
                      36,'Cre Roll Seg',
                      37,'Alt Roll Seg',
                      38,'Drp Roll Seg',
                      39,'Cre Tablesp',
                      40,'Alt Tablesp',
                      41,'Drop Tablesp',
                      42,'Alt Session',
                      43,'Alter User',
                      44,'Commit',
                      45,'Rollback',
                      46,'Save Point',
                      47,'PL/SQL',  to_char(command))   command
from   v$session    s
,      v$process    p
where  s.paddr = p.addr
and lockwait IS NOT NULL
order by spid
,        type desc
,        username
,        osuser
,        sid      
/




