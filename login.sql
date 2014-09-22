set timing on time on pages 1000 lines 150
-- set sqlprompt "_user 'at' _connect_identifier >"
define gname = 'not connected'
column connect_name new_value gname
set termout off
select lower(user) || '@' || name connect_name
from v$database;
set termout on
set sqlprompt '&&gname> '

