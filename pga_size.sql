set pages 999;
column pga_size format 999,999,999

accept hwm number prompt 'Enter high-water mark of connected users:'

select
    &hwm*(2048576+a.value+b.value) pga_size
from
   v$parameter a,
   v$parameter b
where
   a.name = 'sort_area_size'
and
   b.name = 'hash_area_size'
;

