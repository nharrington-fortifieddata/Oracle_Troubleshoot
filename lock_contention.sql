select a.sid, b.username, a.event, a.total_waits, a.time_waited/100 as "time waited (s)", a.average_wait/100 as "avg wait(s)"
from v$session_event a, v$session b
where time_waited > 0
and a.sid=b.sid
and b.username is not NULL
and a.event='enq: TX - row lock contention'
/
