select * 
from v$lock 
where type='TX' 
and request>0;
