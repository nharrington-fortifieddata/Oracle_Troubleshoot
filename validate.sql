REM ======================= Start of Script ============================
REM VALIDATE.SQL 
REM
REM  Purpose:   The purpose of this package is to check all objects
REM             in a given tablespace using the 
REM               ANALYZE TABLE .. VALIDATE STRUCTURE [CASCADE];
REM             command.
REM             The package finds all TABLES and CLUSTERS in the
REM             given tablespace and issues the relevant ANALYZE
REM             commands.
REM
REM USAGE
REM ~~~~~
REM  Please note this is an example script only.
REM  There is no guarantee associated with the output it presents.
REM
REM  Steps to install:
REM     1. Install this package in the SYS schema
REM        Eg: connect internal
REM            @validate
REM        This should create the "ValidateStructure" package.
REM
REM  Steps to use:
REM     1. Ensure SPOOL is enabled to catch output and enable SERVEROUT
REM        Eg:
REM             spool myvalidate.log
REM             execute dbms_output.enable(1000000);
REM             set serveroutput on
REM
REM     2. Run one of:
REM             execute ValidateStructure.TS('TABLESPACE_NAME', TRUE);
REM         or
REM             execute ValidateStructure.TS('TABLESPACE_NAME', FALSE);
REM
REM        to check objects in the named tablespace CASCADE or NOT CASCADE
REM        respectively.
REM        This will run until all requested items are scanned.
REM
REM     3. Errors from the ANALYZE commands are output to DBMS_OUTPUT 
REM        and so any failing objects are listed when all TABLES / CLUSTERS
REM        have been analyzed. More detailed output from failing ANALYZE
REM        commands will be written to the user trace file in USER_DUMP_DEST
REM
set serverout on
CREATE OR REPLACE PACKAGE ValidateStructure
AS
        procedure ts( name varchar2 , casc boolean default true);
END;
/
CREATE OR REPLACE PACKAGE BODY ValidateStructure
AS
  numbad number:=0;
  --
  procedure item( typ varchar2 , schema varchar2, name varchar2, 
                        casc boolean default true) is
    stmt varchar2(200);
    c    number;
    opt  varchar2(20):=null;
  begin
    if (casc) then
      opt:=' CASCADE ';
    end if;
    c:=dbms_sql.open_cursor;
    begin
      stmt:='ANALYZE '||typ||' "'||schema||'"."'||name||'" '||
            'VALIDATE STRUCTURE'||opt;
      dbms_sql.parse(c,stmt,dbms_sql.native);
    exception
      when others then
       dbms_output.put_line( 'Error analyzing '||typ||opt||
                '"'||schema||'.'||name||'" '||sqlerrm);
        numbad:=numbad+1;
    end;
    dbms_sql.close_cursor(c);
  end;
  --
  procedure ts( name varchar2 , casc boolean default true) is
    cursor c is 
        SELECT 'TABLE' typ,owner, table_name FROM DBA_TABLES
         where tablespace_name=upper(name)
        UNION ALL 
        SELECT 'CLUSTER',owner, cluster_name FROM DBA_CLUSTERS
         where tablespace_name=upper(name)
        ;
    n number:=0;
  begin
    numbad:=0;
    for R in C
    loop
        n:=n+1;
        ValidateStructure.item(R.typ,r.owner,r.table_name,casc);
    end loop;
    dbms_output.put_line('Analyzed '||N||' objects with '||numbad||' errors');
    if (numbad>0) then
        raise_application_error(-20002,
         numbad||' errors - SET SERVEROUT ON to view details');
    end if;
  end;
  --
BEGIN
  dbms_output.enable(1000000);
END;
/