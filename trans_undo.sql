SELECT a.sid, a.username, b.xidusn, b.used_urec, b.used_ublk
  FROM v$session a, v$transaction b
  WHERE a.saddr = b.ses_addr
/
