set echo off timing on feedback on
accept tsname prompt 'which tablespace do you want space info about: '

set verify off
set echo off
column "Tablespace" format a30
column "Used MB"    format 99,999,999
column "Free MB"    format 99,999,999
column "Total MB"   format 99,999,999 

select
   df.tablespace_name                          "Tablespace",
   (df.totalspace - fs.freespace)              "Used MB",
   fs.freespace                                "Free MB",
   df.totalspace                               "Total MB",
   round(100 * (fs.freespace / df.totalspace)) "Pct. Free"
from
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) TotalSpace
   from
      dba_temp_files
   where tablespace_name like upper('%&tsname%')
   group by
      tablespace_name
   UNION
   select
      tablespace_name,
      round(sum(bytes) / 1048576) TotalSpace
   from
      dba_temp_files
   where tablespace_name like upper('%&tsname%')
   group by
      tablespace_name
   ) df left join
   (select
      tablespace_name,
      round(sum(bytes_free) / 1048576) FreeSpace
   from
      V$TEMP_SPACE_HEADER
   where tablespace_name like upper('%&tsname%')
   group by
      tablespace_name
   ) fs
on
   df.tablespace_name = fs.tablespace_name
order by 5;

col file_name for a60
Select file_name, bytes/1024/1024 as Meg from dba_temp_files
where tablespace_name like upper('%&tsname%');


