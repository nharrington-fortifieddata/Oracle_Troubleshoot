SET ECHO OFF
set pagesize 10000
set linesize 133
column tablespace format a15 heading 'Tablespace Name'
column segfile# format 9,999 heading 'File|ID'
column spid format 9,999 heading 'Unix|ID'
column segblk# format 999,999,999 heading 'Block|ID'
column size_mb format 999,999,990.00 heading "Mbytes|Used"
column username format a15
column program format a15

select b.tablespace, b.segfile#, b.segblk#,
round(((b.blocks*p.value)/1024/1024),2) size_mb,
a.sid, a.serial#, a.username, a.osuser, a.program, a.status
from v$session a, v$sort_usage b, v$process c, v$parameter p
where p.name='db_block_size' and a.saddr = b.session_addr
and a.paddr=c.addr
order by b.tablespace,b.segfile#,b.segblk#,b.blocks;

