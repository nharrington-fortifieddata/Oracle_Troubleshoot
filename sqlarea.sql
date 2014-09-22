rem
rem FUNCTION: Generate a summary of SQL Area Memory Usage
rem FUNCTION: uses the sqlsummary view.
rem           showing user SQL memory usage
rem
rem sqlsum.sql
rem
column areas heading Used|Areas
column sharable   format 999,999,999      heading Shared|Bytes
column persistent format 999,999,999      heading Persistent|Bytes
column runtime    format 999,999,999      heading Runtime|Bytes
column username   format a15              heading "User"
column mem_sum    format 999,999,999      heading Mem|Sum
start title80 "Users SQL Area Memory Use"
spool rep_out\&db\sqlsum
set pages 59 lines 80
break on report
compute sum of sharable on report
compute sum of persistent on report
compute sum of runtime on report
compute sum of mem_sum on report
select username
	,sum(sharable_mem) Sharable
	,sum( persistent_mem) Persistent
	,sum( runtime_mem) Runtime 
	,count(*) Areas
	,sum(sharable_mem+persistent_mem+runtime_mem) Mem_sum
from sql_summary
group by username
order by 2;
spool off
pause Press enter to continue 
clear columns
clear breaks
set pages 22 lines 80
ttitle off
