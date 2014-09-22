column num_instances heading "Num" format 99999 
column type heading "Object Type" format a12 
column source_size heading "Source" format 99,999,999 
column parsed_size heading "Parsed" format 99,999,999 
column code_size heading "Code" format 99,999,999 
column error_size heading "Errors" format 999,999 
column size_required heading "Total" format 999,999,999 
compute sum of size_required on report 

select count(name) num_instances 
,type 
,sum(source_size) source_size 
,sum(parsed_size) parsed_size 
,sum(code_size) code_size 
,sum(error_size) error_size 
,sum(source_size) 
+sum(parsed_size) 
+sum(code_size) 
+sum(error_size) size_required 
from dba_object_size 
group by type 
order by 2
/

