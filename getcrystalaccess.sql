col a heading "Privilege|Category" format a30
col b heading "Granted Privilege" format a45
SET VERIFY OFF

select 'Roles for ' || grantee a
	, granted_role b
from dba_role_privs
where grantee in (select username from dba_users where profile='CRYSTAL_USER')
union
select 'Sys Privs for ' || grantee 
	,privilege
from dba_sys_privs
where grantee in (select username from dba_users where profile='CRYSTAL_USER')
union
select 'Object Privs for ' || grantee
	,owner||'.'||table_name||' ('||privilege||')'
from dba_tab_privs
where grantee in (select username from dba_users where profile='CRYSTAL_USER')
order by 1,2
/
