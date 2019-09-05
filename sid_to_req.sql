!clear
set head off
set verify off
select 'Request id          :'||a.request_id,
       'SID of the requset  :'||d.sid,
       'Serial Hash value   :'||d.serial#,
       'OS process id       :'||c.spid 
   from
      applsys.fnd_concurrent_requests a,
      applsys.fnd_concurrent_processes b,
      v$process c, v$session d
   where
      a.controlling_manager=b.concurrent_process_id
      and c.pid=b.oracle_process_id
      and c.addr=d.paddr
  and d.sid= NVL('&sid',d.sid)
  and c.spid= NVL('&spid',c.spid) 
  and a.phase_code='R';

