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
REM 	s_sga_high_sql.sql
REM
REM <SQLDIR_GRP>SGA STATS</SQLDIR_GRP>
REM 
REM Author:
REM 	Vitaliy Mogilevskiy 
REM	VMOGILEV
REM	(vit100gain@earthlink.net)
REM 
REM Purpose:
REM Purpose:
REM	<SQLDIR_TXT>
REM	Reports expensive SQL from V$SQLAREA, V$SQLTEXT view
REM	Joins to V$SQLTEXT using ADDRESS column
REM	Prompts	for number of DISK_READS and
REM	PARSING_USER
REM	</SQLDIR_TXT>
REM	
REM Usage:
REM	s_sga_high_sql.sql
REM 
REM Example:
REM	s_sga_high_sql.sql
REM
REM
REM History:
REM	08-01-1998	VMOGILEV	Created
REM
REM

ttitle off
btitle off

clear col
clear breaks

set pages 999
col sql_text         format a78 word_wrapped
col parsing_user     format a30 noprint new_value n_parsing_user
col executions       noprint new_value n_executions
col loads            noprint new_value n_loads
col DISK_READS       noprint new_value n_DISK_READS
col ROWS_PROCESSED   noprint new_value n_ROWS_PROCESSED
col BUFFER_GETS      noprint new_value n_BUFFER_GETS

break on row skip page

ttitle -
       "Parsing User ......... :"  n_parsing_user -
      skip 1 -
       "Number Of Loads ...... :"  n_loads -
      skip 1 -
       "Number Of Executions . :"  n_executions -
      skip 1 -
       "DISK_READS ........... :"  n_DISK_READS -
      skip 1 -
       "BUFFER GETS .......... :"  n_BUFFER_GETS -
      skip 1 -
       "ROWS_PROCESSED ....... :"  n_ROWS_PROCESSED -

select     sql_text
, lpad(username,9)   parsing_user
, executions
, loads
, DISK_READS
, BUFFER_GETS    
, ROWS_PROCESSED 
from v$sqlarea  a
,    dba_users  b
where a.PARSING_USER_ID = b.user_id
and   DISK_READS > &number_of_expensive_DISK_READS
and   b.username = upper('&parsing_username')
order by DISK_READS desc
,        ROWS_PROCESSED desc
,        BUFFER_GETS desc
,        username
/


