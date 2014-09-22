select sid, sql_text
from v$session s, v$sql q
where sid in (select sid
from v$session where state in ('WAITING')
and wait_class != 'Idle' and event='enq: TX - row lock contention'
and (
q.sql_id = s.sql_id or
q.sql_id = s.prev_sql_id));