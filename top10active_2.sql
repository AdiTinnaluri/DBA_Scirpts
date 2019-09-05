/* top10active.sql
    shows the top 10 longest-active user sessions
*/
col osuser format a10 trunc
col LastCallET     format 99,999
col sid format 9999
col spid format a6
col username format a10 trunc
col uprogram format a35 trunc
col machine format a10 trunc
set linesize 180
set verify off
set pages 100
accept trgtuser char default ALL prompt 'Limit to what userid <ALL> : '
accept trgtmod char default ALL prompt 'Limit to which module <ALL> : '
select * from (
select to_char(s.logon_time, 'mm/dd hh:mi:ssAM') loggedon,
  s.sid, s.serial#, s.status,
  floor(last_call_et/60) "LastCallET",
 s.username, s.osuser, 
 p.spid, s.module || ' - ' || s.program uprogram, 
s.machine, s.sql_hash_value
from v$session s, v$process p
where p.addr = s.paddr
  and s.type = 'USER'
  and s.username is not null
  and s.status = 'ACTIVE'
  and (s.username = upper('&trgtuser') or upper('&trgtuser') = 'ALL')
  and (s.module = upper('&trgtmod') or upper('&trgtmod') = 'ALL')
order by 4 desc)
--where rownum < 51;
;

