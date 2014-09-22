select sid
,osuser
,       to_char(logon_time,'MMDDYYYY:HH24:MI') logon_time
,       username
,       type
,       status
from v$session where username is not null
order by logon_time
/
