col sid 9999
col osuser for a20
col command for a20
select sid
,       to_char(logon_time,'MMDDYYYY:HH24:MI') logon_time
,       username
,       osuser
,       status
,   decode(command,
       0,'No Command',
       1,'Create Table',
       2,'Insert',
       3,'Select',
       6,'Update',
       7,'Delete',
       9,'Create Index',
      15,'Alter Table',
      21,'Create View',
      23,'Validate Index',
      35,'Alter Database',
      39,'Create Tablespace',
      41,'Drop Tablespace',
      40,'Alter Tablespace',
      53,'Drop User',
      62,'Analyze Table',
      63,'Analyze Index',
         command||': Other') command
,       sql_address
,       sql_hash_value  
from v$session
where username is not null
and sql_address <> '00' 
and sql_hash_value <> 0
order by logon_time
/
