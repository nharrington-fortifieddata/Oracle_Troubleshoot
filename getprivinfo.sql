ACCEPT p_user PROMPT 'Whose prileges do you want to get: '
SET SERVEROUTPUT ON VERIFY OFF feedback off
DECLARE
  v_username varchar2(30);

  CURSOR sys_privs_cursor IS
    SELECT privilege 
    FROM sys.dba_sys_privs 
    WHERE grantee = v_username;

  CURSOR role_privs_cursor IS
    SELECT granted_role 
    FROM sys.dba_role_privs 
    WHERE grantee = v_username;

  CURSOR obj_privs_cursor IS
    SELECT privilege || ' on ' || owner || '.' || table_name as priv 
    FROM dba_tab_privs 
    WHERE grantee = v_username
    ORDER BY owner, table_name, privilege;

BEGIN  
  SELECT username 
  INTO v_username
  FROM dba_users 
  WHERE username like upper('%&p_user%');

  DBMS_OUTPUT.PUT_LINE ('Privileges for : ' || v_username);
 
  FOR sys_priv_rec IN sys_privs_cursor
  LOOP
     DBMS_OUTPUT.PUT_LINE ('  System Privilege: ' || sys_priv_rec.privilege);
  END LOOP;

  FOR role_priv_rec IN role_privs_cursor
  LOOP
     DBMS_OUTPUT.PUT_LINE ('    Role: ' || role_priv_rec.granted_role);
     FOR role_sys_rec IN (SELECT privilege 
                          FROM sys.dba_sys_privs 
                          WHERE grantee = role_priv_rec.granted_role)
     LOOP
        DBMS_OUTPUT.PUT_LINE ('  ' || role_priv_rec.granted_role ||'''s System Privilege: ' || role_sys_rec.privilege);
     END LOOP;
     
     FOR role_priv_rec2 IN (SELECT granted_role 
    			    FROM sys.dba_role_privs 
			    WHERE grantee = role_priv_rec.granted_role)
     LOOP
        DBMS_OUTPUT.PUT_LINE ('    ' || role_priv_rec.granted_role ||'''s Sub-Role: ' || role_priv_rec2.granted_role);
     END LOOP;
     FOR role_obj_rec IN (SELECT privilege || ' on ' || owner || '.' || table_name as priv 
    			    FROM dba_tab_privs 
    			    WHERE grantee = role_priv_rec.granted_role
    			    ORDER BY owner, table_name, privilege)
     LOOP
        DBMS_OUTPUT.PUT_LINE ('    ' || role_priv_rec.granted_role ||'''s Object Priv: ' || role_obj_rec.priv);
     END LOOP;
  END LOOP;

  FOR obj_priv_rec IN obj_privs_cursor
  LOOP
     DBMS_OUTPUT.PUT_LINE ('      Object Priv: ' || obj_priv_rec.priv);
  END LOOP;

END;
/
