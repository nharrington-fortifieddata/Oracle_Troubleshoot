set lines 150 pages 1000 echo off
COLUMN sid     FORMAT 99999
COLUMN serial# FORMAT 9999999
COLUMN machine FORMAT A30
COLUMN progress_pct FORMAT 99999999.00
COLUMN elapsed FORMAT A10
COLUMN remaining FORMAT A10
COLUMN sql_text FORMAT A60
SELECT s.sid,
       s.serial#,
       s.machine,
       TRUNC(sl.elapsed_seconds/60) || ':' || MOD(sl.elapsed_seconds,60) elapsed,
       TRUNC(sl.time_remaining/60) || ':' || MOD(sl.time_remaining,60) remaining,
       ROUND(sl.sofar/sl.totalwork*100, 2) progress_pct,
       SUBSTR(sql_text,1,300) as SQL_TEXT	
FROM   v$session s,
       v$session_longops sl,
	V$sql sq
WHERE  s.sid     = sl.sid
AND    s.serial# = sl.serial#
AND 	sl.sql_address = sq.address
AND  sl.totalwork > 0
ORDER BY remaining
/
