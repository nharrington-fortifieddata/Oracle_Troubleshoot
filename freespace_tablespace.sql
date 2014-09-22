COLUMN tablespace_name FORMAT A15
COLUMN "Total Free (MB) " FORMAT 999,999,999,999
COLUMN "Largest Free Extent (MB) " FORMAT 999,999,999,999

Select tablespace_name,
Sum(bytes/(1024*1024)) "Total Free (MB) ",
Max(bytes/(1024*1024)) "Largest Free Extent (MB) "
From dba_free_space
Group By tablespace_name; 

