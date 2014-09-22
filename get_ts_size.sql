set echo off timing on feedback on verify off lines 120
accept tsname prompt 'Tablespace Name: '

col file_name for a60

select file_name, bytes/1024/1024 as Meg from dba_data_files
where tablespace_name = upper('&tsname');

