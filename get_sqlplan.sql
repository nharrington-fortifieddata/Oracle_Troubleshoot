col operation for a30
col options for a20
col object_name for a30
set lines 130 pages 1000 verify off

SELECT operation, options, object_name, cost
FROM v$sql_plan  
WHERE address = '&sql_address'
AND hash_value = &sql_hashvalue;