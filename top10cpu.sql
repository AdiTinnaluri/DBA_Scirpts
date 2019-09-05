/* the hash 1425819161 is the ccmgr polling */
col LastCallET format 99,999
col cpumins format 99,999
col status format a1 trunc
col module format a20
col username format a15
col logontime format a12
col machine format a15 trunc
col sid format 9999
select * from (
select 'P',s.sid, s.status, t.value/100/60 cpumins , 
	floor(last_call_et/60) "LastCallET",
	to_char(s.logon_time,'mm/dd hh24:mi') logontime,
	s.username,s.process, p.spid, s.module , s.machine, s.sql_hash_value
from v$sesstat t, v$session s, v$process p
 where t.statistic# = 12
and s.sid = t.sid
and s.paddr = p.addr
and s.type = 'USER' 
and s.sql_hash_value != 1425819161
union
select 'N',s.sid, s.status, t.value*-1/100/60 cpumins ,
        floor(last_call_et/60) "LastCallET",
        to_char(s.logon_time,'mm/dd hh24:mi') logontime,
        s.username,s.process, p.spid, s.module , s.machine, s.sql_hash_value
from v$sesstat t, v$session s, v$process p
 where t.statistic# = 12
and s.sid = t.sid
and s.paddr = p.addr
and s.type = 'USER'
and s.sql_hash_value != 1425819161
and t.value < 0
order by 4 desc)
where rownum < 11
/

