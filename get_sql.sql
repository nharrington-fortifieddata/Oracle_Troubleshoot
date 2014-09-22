set lines 130 pages 1000 long 4000
col sql_text for a100

SELECT sql_text
FROM v$sql  
WHERE address = '&sql_address'
AND hash_value = &sql_hashvalue;