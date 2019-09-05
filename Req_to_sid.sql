set verify off
set head off
col reqid format 999999999
col sesid format a10 
col ospid format a10 
select
   'Concurrent request number :'||a.request_id ,
   'Oracle session id(SID)    :'||d.sid,
   'Serial Hash value         :'||d.serial#,
   'OS process id (SPID)      :'||c.spid
from
   applsys.fnd_concurrent_requests a,
   applsys.fnd_concurrent_processes b,
   v$process c, 
   v$session d
where
   a.controlling_manager=b.concurrent_process_id
   and c.pid=b.oracle_process_id
   and c.addr=d.paddr
   and a.request_id=&RequestId
   and a.phase_code='R';

