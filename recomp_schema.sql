set timing off
accept userid prompt 'which schema do you want to recompile objects in: '
set echo off feedback 0 pages 0 head off lines 120 verify off
spool tmp/RECOMP.&userid
PROMPT set echo on feedback on
PROMPT spool RECOMP.&userid..log

SELECT 'SELECT instance_name, sysdate FROM v$instance;' FROM dual;

SELECT 'ALTER ' || object_type || ' ' || owner || '."' || object_name || '" COMPILE;'
FROM dba_objects where status <> 'VALID' and object_type not iN ('PACKAGE BODY','SYNONYM','TYPE BODY')
AND owner = upper('&userid');

SELECT 'ALTER PACKAGE ' || owner || '."' || object_name || '" COMPILE BODY;'
FROM dba_objects where status <> 'VALID' and object_type = 'PACKAGE BODY'
AND owner = upper('&userid');

SELECT 'ALTER TYPE ' || owner || '."' || object_name || '" COMPILE BODY;'
FROM dba_objects where status <> 'VALID' and object_type = 'TYPE BODY'
AND owner = upper('&userid');

SELECT 'desc ' || owner || '."' || object_name || '"'
FROM dba_objects where status <> 'VALID' and object_type = 'SYNONYM'
AND owner = upper('&userid');

PROMPT spool off
spool off
set timing on
@tmp/RECOMP.&userid
set lines 140
col object_name for a30
set echo off feedback on pages 100 head on 
Select object_type, object_name, status from dba_objects
where status <> 'VALID' and owner = upper('&userid');
