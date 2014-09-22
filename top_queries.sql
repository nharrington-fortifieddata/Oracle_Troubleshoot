set wrap on
set tab off
set trimspool on
set linesize 6000
set pagesize 60
set heading on
set serveroutput on
column SQL_TEXT format A80 wrapped



select * from 
(select executions, disk_reads, buffer_gets, sql_text
        from v$sqlarea 
        order by disk_reads / decode(executions,0,1,executions) desc)
where rownum <= 10
/

