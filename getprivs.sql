accept usr prompt "Enter the USERNAME whose privileges you would like to survey: "
break on a skip 1
col a heading "Privilege|Category" format a30
col b heading "Granted Privilege" format a30
SET VERIFY OFF

select 'Roles for ' || grantee a
	, granted_role b
from dba_role_privs
where grantee like upper('&usr')
union
select 'Sys Privs for ' || grantee 
	,privilege
from dba_sys_privs
where grantee like upper('&usr')
union
select 'Object Privs for ' || grantee
	,owner||'.'||table_name||' ('||privilege||')'
from dba_tab_privs
where grantee like upper('&usr')
order by 1,2
/
