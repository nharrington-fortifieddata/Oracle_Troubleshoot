set timing off
accept userid prompt 'which schema do you want to remove objects from: '

select to_char(sysdate, 'Dy DD-Mon-YYYY HH24:MI:SS') as "Current Time"
from dual;

set echo off feedback 0 pages 0 head off lines 120 verify off
spool DROP_USER.&userid
PROMPT set echo on feedback on
PROMPT spool DROP_USER.&userid..log
SELECT 'SELECT instance_name, sysdate FROM v$instance;' FROM dual;
SELECT 'DROP TABLE ' || owner || '."' || table_name || '" cascade constraints purge;'
FROM dba_tables where owner = upper('&userid');

SELECT 'DROP ' || object_type || ' ' || owner || '."' || object_name || '";'
FROM dba_objects
WHERE owner = upper('&userid')
AND object_type not in ('TABLE','INDEX','DATABASE LINK','PACKAGE BODY','TRIGGER','LOB','TABLE PARTITION','INDEX PARTITION');

PROMPT col owner for a30
PROMPT col object_type for a30
SELECT 'SELECT owner, object_type, count(*) from dba_objects ' || chr(10) || 
       'WHERE owner = upper(''&userid'') GROUP BY owner, object_type;'
FROM DUAL;
select to_char(sysdate, 'Dy DD-Mon-YYYY HH24:MI:SS') as "Current Time"
from dual;

PROMPT spool off
spool off
PROMPT execute tmp/DROP_USER.&userid to remove the objects

set timing on
