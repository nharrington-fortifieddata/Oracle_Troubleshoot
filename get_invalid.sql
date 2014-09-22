accept schema_name prompt 'Which userid do want to get invalid objects: '
select
 'ALTER ' || 
  case when object_type = 'PACKAGE BODY' then 'PACKAGE'
                   else object_type end
  || ' ' || owner || '.' || object_name || 
  case when object_type = 'PACKAGE BODY' then ' compile body;'
                   else ' compile;'  end
from dba_objects
where owner like upper('%&schema_name%')
and status <> 'VALID'
/
