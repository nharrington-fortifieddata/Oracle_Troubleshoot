col object for a35
col machine for a40
col osuser for a10
col username for a15

set lines 180 pages 100

select
   c.owner || '.' || c.object_name as object,
   c.object_type,
   b.sid,
   b.serial#,
   b.username,
   b.osuser,
   b.machine
from
   v$locked_object a ,
   v$session b,
   dba_objects c
where
   b.sid = a.session_id
and
   a.object_id = c.object_id
/
