SELECT s.sid,
       p.kglpnmod LockMode,
       p.kglpnreq LockRequest,
       b.kglnaown ObjectOwner,
       b.kglnaobj ObjectName
  FROM x$kglpn p, x$kglob b, v$session s
 WHERE s.saddr = p.kglpnuse
   AND p.kglpnhdl = b.kglhdadr
   AND p.kglpnhdl IN (SELECT p1raw FROM v$session_wait
                      WHERE event LIKE '%library cache lock%')
/
