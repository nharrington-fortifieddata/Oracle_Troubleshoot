SET ECHO off 
REM NAME:  TFSSYPRV.SQL 
REM USAGE:"@path/tfssyprv" 
REM -------------------------------------------------------------------------- 
REM REQUIREMENTS: 
REM  SELECT ANY TABLE 
REM -------------------------------------------------------------------------- 
REM AUTHOR:  
REM    Geert De Paep      
REM -------------------------------------------------------------------------- 
REM PURPOSE: 
REM    Show the SYSTEM privileges a certain user has.  
REM --------------------------------------------------------------------------- 
REM EXAMPLE: 
REM    SYSTEM PRIVILEGES 
REM        MARTY            
REM        CONNECT                    ALTER SESSION 
REM                                   CREATE CLUSTER  
REM        			      CREATE DATABASE LINK  
REM                                   CREATE SEQUENCE  
REM                                   CREATE SESSION  
REM                       	      CREATE SYNONYM  
REM                                   CREATE TABLE  
REM                                   CREATE VIEW  
REM       MARTY          
REM          DBA             
REM             EXP_FULL_DATABASE     Role of 2 privs  
REM          DBA             
REM             IMP_FULL_DATABASE     Role of 35 privs 
REM          DBA                      DBA-role (+- 80 privs) 
REM  
REM --------------------------------------------------------------------------- 
REM DISCLAIMER: 
REM    This script is provided for educational purposes only. It is NOT  
REM    supported by Oracle World Wide Technical Support. 
REM    The script has been tested and appears to work as intended. 
REM    You should always run new scripts on a test instance initially. 
REM -------------------------------------------------------------------------- 
REM Main text of script follows: 
 
set verify off  
set head off  
set feedback off  
set pages 20  
undef naam  
accept naam char prompt 'Enter username to show SYSTEM privileges of: '  
  
set termout off  
drop table testpriv;  
-- DBA_ROLE_PRIV indicates which role is granted to which user  
create table testpriv  
(grantee,granted_role,ptype)  
as  
select grantee,granted_role,'R'  
from sys.dba_role_privs;  
  
-- DBA_SYS_PRIV indicates which privilege is granted to which user  
--              directly (without using roles).  
insert into testpriv  
select distinct grantee,   
       decode(grantee, 'DBA', 'DBA-role (+- 80 privs)',  
                       'IMP_FULL_DATABASE','Role of 35 privs',  
                       'EXP_FULL_DATABASE','Role of 2 privs',  
                        privilege),   
       'P'  
from sys.dba_sys_privs  
--where grantee != 'DBA'  
;  
  
set termout on  
  
-- testpriv now contains:  
--  (user, role)  
--  (role, privs)  
--  (user, privs)  
-- So display it in a connect by format:  
col title format a30 heading "System privileges" trunc  
prompt SYSTEM PRIVILEGES  
break on title  
  
select lpad(grantee,length(grantee)+level*3) title,   
       decode (ptype,'R',null,'P',granted_role)  
from testpriv  
connect by grantee = prior granted_role  
start with grantee = upper('&naam')  
/  
