col name for a50
set linesize 132
set pages 666
-- drop temporary table
drop table jh$filestats;
create table jh$filestats as 
select file#, PHYBLKRD, PHYBLKWRT
from v$filestat;
prompt Waiting......
exec dbms_lock.sleep(10);

prompt NOTE: Only the top 10 files...
select * from (
select df.name, fs.phyblkrd - t.phyblkrd "Reads",
fs.PHYBLKWRT - t.PHYBLKWRT "Writes",
(fs.PHYBLKRD+fs.PHYBLKWRT) - (t.PHYBLKRD+t.PHYBLKWRT) "Total IO"
from v$filestat fs, v$datafile df, jh$filestats t
where df.file# = fs.file#
and t.file# = fs.file#
and (fs.PHYBLKRD+fs.PHYBLKWRT) - (t.PHYBLKRD+t.PHYBLKWRT) > 0
order by "Total IO" desc )
where rownum <= 10
/
drop table jh$filestats;
