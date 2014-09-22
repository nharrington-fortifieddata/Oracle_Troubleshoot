select 
substr(a.file#,1,2) "#", 
substr(a.name,1,50) "File Name", 
a.status, 
a.bytes, 
b.phyrds, 
b.phywrts 
from v$datafile a, v$filestat b 
where a.file# = b.file#;
