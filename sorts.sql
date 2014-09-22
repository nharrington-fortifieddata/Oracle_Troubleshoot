SET HEADING OFF
SET FEEDBACK OFF
COLUMN name FORMAT a30
COLUMN value FORMAT 99999990

SELECT name, value FROM v$sysstat 
WHERE name IN ('sorts (memory)', 'sorts (disk)');

