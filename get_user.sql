-- get_user

-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/script_creation/user_ddl.sql
-- Author       : Tim Hall
-- Description  : Displays the DDL for a specific user.
-- Call Syntax  : @user_ddl (username)
-- Last Modified: 28/01/2006
-- -----------------------------------------------------------------------------------

set long 20000 longchunksize 20000 pagesize 0 linesize 1000 feedback off verify off trimspool on
column ddl format a1000

begin
   dbms_metadata.set_transform_param (dbms_metadata.session_transform, 'SQLTERMINATOR', true);
   dbms_metadata.set_transform_param (dbms_metadata.session_transform, 'PRETTY', true);
end;
/
 
DECLARE 
	CURSOR c1 is
		SELECT USERNAME FROM DBA_USERS WHERE USERNAME NOT IN ('ANONYMOUS'
,'APEX_PUBLIC_USER'
,'CTXSYS'
, 'DBSNMP'
,'DIP'
,'EXFSYS'
,'FLOWS_30000'
,'FLOWS_FILES'
,'LBACSYS'
,'MDDATA'
,'MDSYS'
,'MGMT_VIEW'
,'OLAPSYS'
,'OWBSYS'
,'ORACLE_OCM'
,'ORDPLUGINS'
,'ORDSYS'
,'OUTLN'
,'SI_INFORMTN_SCHEMA'
,'SPATIAL_CSW_ADMIN_USR'
,'SPATIAL_WFS_ADMIN_USR'
,'SYS'
,'SYSMAN'
,'SYSTEM'
,'TSMSYS'
,'WK_TEST'
,'WKSYS'
,'WKPROXY'
,'WMSYS'
,'XDB'
,'XS$NULL'
,'ADM_PARALLEL_EXECUTE_TASK'
        ,'APEX_ADMINISTRATOR_ROLE'
        ,'AQ_ADMINISTRATOR_ROLE'
        ,'AQ_USER_ROLE'
        ,'AUTHENTICATEDUSER'
        ,'CAPI_USER_ROLE'
        ,'CONNECT'
        ,'CSW_USR_ROLE'
        ,'CTXAPP'
        ,'CWM_USER'
        ,'DATAPUMP_EXP_FULL_DATABASE'
        ,'DATAPUMP_IMP_FULL_DATABASE'
        ,'DBA'
        ,'DBFS_ROLE'
        ,'DELETE_CATALOG_ROLE'
        ,'EJBCLIENT'
        ,'EXECUTE_CATALOG_ROLE'
        ,'EXP_FULL_DATABASE'
        ,'GATHER_SYSTEM_STATISTICS'
        ,'GLOBAL_AQ_USER_ROLE'
        ,'HS_ADMIN_EXECUTE_ROLE'
        ,'HS_ADMIN_ROLE'
        ,'HS_ADMIN_SELECT_ROLE'
        ,'IMP_FULL_DATABASE'
        ,'JAVADEBUGPRIV'
        ,'JAVAIDPRIV'
        ,'JAVASYSPRIV'
        ,'JAVAUSERPRIV'
        ,'JAVA_ADMIN'
        ,'JAVA_DEPLOY'
        ,'JMXSERVER'
        ,'LBAC_DBA'
        ,'LOGSTDBY_ADMINISTRATOR'
        ,'MGMT_USER'
        ,'OEM_ADVISOR'
        ,'OEM_MONITOR'
        ,'OLAPI_TRACE_USER'
        ,'OLAP_DBA'
        ,'OLAP_USER'
        ,'OLAP_XS_ADMIN'
        ,'ORDADMIN'
        ,'OWB$CLIENT'
        ,'OWB_DESIGNCENTER_VIEW'
        ,'OWB_USER'
        ,'PLUSTRACE'
        ,'RECOVERY_CATALOG_OWNER'
        ,'RESOURCE'
        ,'SCHEDULER_ADMIN'
        ,'SELECT_CATALOG_ROLE'
        ,'SNMPAGENT'
        ,'SPATIAL_CSW_ADMIN'
        ,'SPATIAL_WFS_ADMIN'        
        ,'WFS_USR_ROLE'
        ,'WM_ADMIN_ROLE'
        ,'XDBADMIN'
        ,'XDB_SET_INVOKER'
        ,'XDB_WEBSERVICES'
        ,'XDB_WEBSERVICES_OVER_HTTP'
        ,'XDB_WEBSERVICES_WITH_PUBLIC' ) order by username;
			v_username VARCHAR2(30);
DECLARE
CURSOR all_users IS
  3          SELECT * from dba_users
  5          WHERE USERNAME NOT IN ('ANONYMOUS'
		,'APEX_PUBLIC_USER'
		,'CTXSYS'
		, 'DBSNMP'
		,'DIP'
		,'EXFSYS'
		,'FLOWS_30000'
		,'FLOWS_FILES'
		,'LBACSYS'
		,'MDDATA'
		,'MDSYS'
		,'MGMT_VIEW'
		,'OLAPSYS'
		,'OWBSYS'
		,'ORACLE_OCM'
		,'ORDPLUGINS'
		,'ORDSYS'
		,'OUTLN'
		,'SI_INFORMTN_SCHEMA'
		,'SPATIAL_CSW_ADMIN_USR'
		,'SPATIAL_WFS_ADMIN_USR'
		,'SYS'
		,'SYSMAN'
		,'SYSTEM'
		,'TSMSYS'
		,'WK_TEST'
		,'WKSYS'
		,'WKPROXY'
		,'WMSYS'
		,'XDB'
		,'XS$NULL'
		,'ADM_PARALLEL_EXECUTE_TASK'
        ,'APEX_ADMINISTRATOR_ROLE'
        ,'AQ_ADMINISTRATOR_ROLE'
        ,'AQ_USER_ROLE'
        ,'AUTHENTICATEDUSER'
        ,'CAPI_USER_ROLE'
        ,'CONNECT'
        ,'CSW_USR_ROLE'
        ,'CTXAPP'
        ,'CWM_USER'
        ,'DATAPUMP_EXP_FULL_DATABASE'
        ,'DATAPUMP_IMP_FULL_DATABASE'
        ,'DBA'
        ,'DBFS_ROLE'
        ,'DELETE_CATALOG_ROLE'
        ,'EJBCLIENT'
        ,'EXECUTE_CATALOG_ROLE'
        ,'EXP_FULL_DATABASE'
        ,'GATHER_SYSTEM_STATISTICS'
        ,'GLOBAL_AQ_USER_ROLE'
        ,'HS_ADMIN_EXECUTE_ROLE'
        ,'HS_ADMIN_ROLE'
        ,'HS_ADMIN_SELECT_ROLE'
        ,'IMP_FULL_DATABASE'
        ,'JAVADEBUGPRIV'
        ,'JAVAIDPRIV'
        ,'JAVASYSPRIV'
        ,'JAVAUSERPRIV'
        ,'JAVA_ADMIN'
        ,'JAVA_DEPLOY'
        ,'JMXSERVER'
        ,'LBAC_DBA'
        ,'LOGSTDBY_ADMINISTRATOR'
        ,'MGMT_USER'
        ,'OEM_ADVISOR'
        ,'OEM_MONITOR'
        ,'OLAPI_TRACE_USER'
        ,'OLAP_DBA'
        ,'OLAP_USER'
        ,'OLAP_XS_ADMIN'
        ,'ORDADMIN'
        ,'OWB$CLIENT'
        ,'OWB_DESIGNCENTER_VIEW'
        ,'OWB_USER'
        ,'PLUSTRACE'
        ,'RECOVERY_CATALOG_OWNER'
        ,'RESOURCE'
        ,'SCHEDULER_ADMIN'
        ,'SELECT_CATALOG_ROLE'
        ,'SNMPAGENT'
        ,'SPATIAL_CSW_ADMIN'
        ,'SPATIAL_WFS_ADMIN'        
        ,'WFS_USR_ROLE'
        ,'WM_ADMIN_ROLE'
        ,'XDBADMIN'
        ,'XDB_SET_INVOKER'
        ,'XDB_WEBSERVICES'
        ,'XDB_WEBSERVICES_OVER_HTTP'
        ,'XDB_WEBSERVICES_WITH_PUBLIC' ) order by username;
  
        TYPE u_name IS TABLE OF dba_users.username%TYPE;
  
            u_names u_name;
			inx1 PLS_INTEGER;
   BEGIN
       OPEN all_users;
       FETCH all_users BULK COLLECT INTO u_names;
       CLOSE all_users;
 
       FOR inx1 IN 1..u_names.count LOOP
           u_names(inx1) := UPPER(u_names(inx1));
           DBMS_OUTPUT.PUT_LINE (u_names(inx1));
       END LOOP;
 
       FORALL x IN u_names.first..u_names.last
          DBMS_OUTPUT.PUT_LINE (u_names(x));
   END;



exec:u_names(x) := upper('&1');

select dbms_metadata.get_ddl('USER', u.username) AS ddl
from   dba_users u
where  u.username = :u_names(x)
union all
select dbms_metadata.get_granted_ddl('TABLESPACE_QUOTA', tq.username) AS ddl
from   dba_ts_quotas tq
where  tq.username = :v_username
and    rownum = 1
union all
select dbms_metadata.get_granted_ddl('ROLE_GRANT', rp.grantee) AS ddl
from   dba_role_privs rp
where  rp.grantee = :v_username
and    rownum = 1
union all
select dbms_metadata.get_granted_ddl('SYSTEM_GRANT', sp.grantee) AS ddl
from   dba_sys_privs sp
where  sp.grantee = :v_username
and    rownum = 1
union all
select dbms_metadata.get_granted_ddl('OBJECT_GRANT', tp.grantee) AS ddl
from   dba_tab_privs tp
where  tp.grantee = :v_username
and    rownum = 1
union all
select dbms_metadata.get_granted_ddl('DEFAULT_ROLE', rp.grantee) AS ddl
from   dba_role_privs rp
where  rp.grantee = :v_username
and    rp.default_role = 'YES'
and    rownum = 1
union all
select to_clob('/* Start profile creation script in case they are missing') AS ddl
from   dba_users u
where  u.username = :v_username
and    u.profile <> 'DEFAULT'
and    rownum = 1
union all
select dbms_metadata.get_ddl('PROFILE', u.profile) AS ddl
from   dba_users u
where  u.username = :v_username
and    u.profile <> 'DEFAULT'
union all
select to_clob('End profile creation script */') AS ddl
from   dba_users u
where  u.username = :v_username
and    u.profile <> 'DEFAULT'
and    rownum = 1
/

set linesize 80 pagesize 14 feedback on trimspool on verify on