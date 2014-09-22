select sess_io.sid,
       sess_io.block_gets,
       sess_io.consistent_gets,
       sess_io.physical_reads,
       sess_io.block_changes,
       sess_io.consistent_changes
  from v$sess_io sess_io, v$session sesion
 where sesion.sid = sess_io.sid
   and sesion.username is not null
/