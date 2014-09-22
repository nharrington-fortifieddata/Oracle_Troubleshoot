set echo off
set feedback off
set verify off
set time off
set lines 170
set pages 0
alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
set trimspool on
 
select /*+ use_hash(a b c) */
       SYSDATE || '~' ||
       a.SID || '~' ||
       b.username || '~' ||
       a.SEQ# || '~' ||
       a.EVENT || '~' ||
       a.WAIT_TIME || '~' ||
       a.SECONDS_IN_WAIT || '~' ||
       a.STATE || '~' ||
       a.P1TEXT || '~' ||
       a.P1RAW || '~' ||
       a.P1 || '~' ||
       a.P2TEXT || '~' ||
       a.P2RAW || '~' ||
       a.P2 || '~' ||
       a.P3TEXT || '~' ||
       a.P3RAW || '~' ||
       a.P3 || '~' ||
       c.address || '~'
  from v$session_wait a,
       v$session b,
       v$sql c
 where a.event not like '%message%'
   and a.event not like '%smon%'
   and a.event not like '%pmon%'
   and a.event not like '%time%'
   and a.sid = b.sid
   and b.sql_address = c.address (+)
   and b.sql_hash_value = c.hash_value (+);

