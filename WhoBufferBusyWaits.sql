select
   p1 "File #",
   p2 "Block #",
   p3 "Reason Code"
from
   v$session_wait
where
   event = 'buffer busy waits'
/