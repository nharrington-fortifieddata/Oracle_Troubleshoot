break on username skip 2 on sid skip 1

compute sum label "Sid Space" of space_meg on sid 
compute sum label "User Space" of space_meg on username
set pages 1000
set lines 150

select a.username, a.sid,a.logon_time, b.cache_lobs, b.nocache_lobs, c.segtype, c.extents, c.blocks, c.space_Meg
from v$session a join v$temporary_lobs b
on a.sid = b.sid
join (select session_addr, segtype, extents, blocks, (blocks*value)/1024/1024 as Space_Meg
      from v$tempseg_usage, v$parameter
      where name = 'db_block_size') c
on a.saddr = c.session_addr
order by username, a.sid
/

clear breaks
