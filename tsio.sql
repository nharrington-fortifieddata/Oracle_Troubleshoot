column name format a18 heading 'Tablespace' jus cen
column file format a50 heading 'File Name' jus cen
column pbr format 99,999,999,990 heading 'Physical|Blocks|Read' jus cen 
column pbw format 99,999,999,990 heading 'Physical |Blocks|Written' jus cen 
column pyr format 99,999,999,990 heading 'Physical |Reads' jus cen 
column pyw format 99,999,999,990 heading 'Physical|Writes' jus cen

ttitle center 'Disk I/O Activity by file' skip 2
compute sum of pyr on report
compute sum of pyw on report
compute sum of pbr on report
compute sum of pbw on report
break on report
select 
df.tablespace_name name,
df.file_name "file",
f.phyrds pyr,
f.phyblkrd pbr,
f.phywrts pyw,
f.phyblkwrt pbw
from v$filestat f, dba_data_files df
where
f.file# = df.file_id
order by df.tablespace_name
/
