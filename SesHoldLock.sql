select * 
from v$lock 
where type='TX' 
and lmode>0;