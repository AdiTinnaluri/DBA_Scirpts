select 'sid ....  :'||s.sid,
       'serial# ..:'||s.serial#
from v$session s, v$process p 
where p.spid=&spid and p.addr=s.paddr;
