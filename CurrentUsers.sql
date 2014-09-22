col machine for a30
select username, osuser, machine, status, logon_time from V$session where username is not null and username <> 'SYSTEM' order by status, logon_time
/
