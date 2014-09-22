set feedback on timing on 
col wait_class for a20
Select a.blocking_session, a.sid, a.username as blocked_user, b.username as blocking_user ,a.wait_class, a.seconds_in_wait
From v$session a join v$session b
ON a.blocking_session = b.sid
and a.blocking_session is not NULL
order by a.blocking_session;