set echo off
Prompt Show locks currently being held:
Prompt 
select o.object_name,l.oracle_username,l.os_user_name,l.session_id
,decode(l.locked_mode,2,'Row-S',3,'Row-X',4,'Share',5,'S/Row-X',6 ,'Exclusive','NULL')
from user_objects o , v$locked_object l
where o.object_id = l.object_id
/
set echo on