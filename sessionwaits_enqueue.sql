set lines 170
set pages 1000
set time on
column sid format 999999
column seq# format 999999
column event format a30
column p1text format a35 newline
column p1 format 99999999999
column p2text format a15
column p2 format 99999999999
column p3text format a10
column p3 format 99999999
column wait_time format 99999999 newline
column seconds_in_wait format 99999999
column state format a25
column ltype format a35
column lmode format a15 newline
column blking format a5
column blked format a5
column username format a15
column sql_text format a80 wrap newline
column filler newline
 
spool sessionwaits_enqueue.txt
 
select /*+ use_hash(a b c d t) */ a.SID,
       a.SEQ#,
       a.EVENT,
       a.P1TEXT,
       a.P1,
       a.P2TEXT,
       a.P2,
       a.P3TEXT,
       a.P3,
       a.WAIT_TIME,
       a.SECONDS_IN_WAIT,
       a.STATE,
       b.username,
       d.id1,
       d.id2,
       decode (d.type,'TX','TX ID1=Dec. RBS and Slot  ID2=Dec. Wrap Number',
                      'TM','TM ID1=OID                ID2=n/a',
                      'TS','TS ID1=TS#                ID2=Rel. DBA',
                      'ST','ST ID1=Space Mgmt Enqueue   ID2=n/a',
                      'UL','USR ID1=n/a               ID2=n/a',
                      'BL','Buffer hash table instance',
                      'NA','..NZ Library cache pin instance (A..Z = namespace)',
                      'CF','Control file schema global enqueue',
                      'PF','Password File ',
                      'CI','Cross-instance function invocation instance',
                      'PI','PS Parallel operation',
                      'CU','Cursor bind ',
                      'PR','Process startup ',
                      'DF','Data file instance ',
                      'QA','..QZ Row cache instance (A..Z = cache)',
                      'DL','Direct loader parallel index create',
                      'RT','Redo thread global enqueue',
                      'DM','Mount/startup db primary/secondary instance',
                      'SC','System commit number instance',
                      'DR','Distributed recovery process',
                      'SM','SMON ',
                      'DX','Distributed transaction entry',
                      'SN','Sequence number instance',
                      'FS','File set ',
                      'SQ','Sequence number enqueue',
                      'HW','Space management operations on a specific segment',
                      'SS','Sort segment ',
                      'IN','Instance number ',
                      'ST','Space transaction enqueue',
                      'IR','Instance recovery serialization global enqueue',
                      'SV','Sequence number value',
                      'IS','Instance state ',
                      'TA','Generic enqueue ',
                      'IV','Library cache invalidation instance',
                      'TS','Temporary segment enqueue (ID2=0)',
                      'JQ','Job queue ',
                      'TS','New block allocation enqueue (ID2=1)',
                      'KK','Thread kick ',
                      'TT','Temporary table enqueue',
                      'LA',' .. LP Library cache lock instance lock (A..P = namespace)',
                      'UN','User name ',
                      'MM','Mount definition global enqueue',
                      'US','Undo segment DDL ',
                      'MR','Media recovery ',
                      'WL','Being-written redo log instance',
                      'SYS') ltype,
       decode (d.lmode,1,'Null',
                       2,'Row-S',
                       3,'Row-X',
                       4,'Share',
                       5,'S/Row-X',
                       6,'Exclusive') lmode,
       decode (d.request,1,'Null',
                       2,'Row-S (SS)',
                       3,'Row-X (SX)',
                       4,'Share (S)',
                       5,'S/Row-X (SSX)',
                       6,'Exclusive (X)') rmode,
       decode (d.request,null, 'No', 0,'No', 1, 'No', 'Yes') blked,
       decode (d.block,null, 'No', 0,'No', 1, 'No', 'Yes') blking,
       decode (d.type, 'TM', null, decode (d.request,null, 'Not Blocked', 0,'Not Blocked','Waiting on session '||to_char(blkr.sid))) details,
       d.ctime,
       c.sql_text,
       t.XIDUSN,
       t.XIDSLOT,
       t.XIDSQN,
       '=======================================================================================================================' filler
  from
       v$session_wait a,
       v$session b,
       v$lock d,
       v$sql c,
       v$lock blkr,
       v$transaction t
 where a.event in ('enqueue', 'row cache lock')
   and lower(a.event) not like '%message%'
   and lower(a.event) not like '%timer%'
   and lower(a.event) not like '%jobq%'
   and a.sid = b.sid (+)
   and b.sql_address = c.address (+)
   and b.sql_hash_value = c.hash_value (+)
   and a.sid=d.sid(+)
   and a.p2 = d.id1(+)
   and a.p3 = d.id2(+)
   and d.id1 = blkr.id1(+)
   and blkr.request(+) = 0
   and b.taddr = t.addr (+)
 order by 1;
 
 
-- SELECT /*+ use_hash(t s q) */ t.addr,
--        t.xidusn USN,
--        t.xidslot SLOT,
--        t.xidsqn SQN,
--        t.status,
--        t.start_time,
--        t.used_ublk UBLK,
--        t.used_urec UREC,
--        t.log_io LOG,
--        t.phy_io PHY,
--        t.cr_get,
--        t.cr_change CR_CHA,
--        q.sql_text,
--       '=======================================================================================================================' filler
--    FROM v$transaction t,
--         v$session s,
--         v$sql q
--   WHERE s.sid = &blocking_sid
--     AND t.addr = s.taddr (+)
--     and s.sql_address = q.address (+)
--     and s.sql_hash_value = q.hash_value (+);
--
--
 
--spool off

