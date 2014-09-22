col "Privilege, Roles and Users" for a60
set lines 120

select
  lpad(' ', 2*level) || c "Privilege, Roles and Users"
from
  (
  /* THE PRIVILEGES */
    select 
      null   p, 
      name   c
    from 
      system_privilege_map
    where
      name like upper('%&enter_privliege%')
  /* THE ROLES TO ROLES RELATIONS */ 
  union
    select 
      granted_role  p,
      grantee       c
    from
      dba_role_privs
  /* THE ROLES TO PRIVILEGE RELATIONS */ 
  union
    select
      privilege     p,
      grantee       c
    from
      dba_sys_privs
  )
start with p is null
connect by p = prior c;
