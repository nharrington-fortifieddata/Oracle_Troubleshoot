col address for a 15
col hash_value for 9999999999999999
col plan_hash_value for 99999999999999999
col sql_text for a60
set lines 150 pages 1000

select address,hash_value,child_number,plan_hash_value,sql_text
from v$sql where upper(sql_text) like upper('%&query_info%')
and sql_text not like '%v$sql%'
/
