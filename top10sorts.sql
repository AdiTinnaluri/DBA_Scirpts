/* topsort.sql
     see the top 10 consumers of sort segments
*/
set pages 100
set lines 180
col sid format 999999
col tablespace format a10
col username format a25
col noexts format 999999 head EXTS
col proginfo format a30 trunc
col mbused format 999,999.90
col status format a1 trunc
set verify off
select * from (
select s.sid,
       s.status,
       s.sql_hash_value sesshash,
       u.SQLHASH sorthash, 
       s.username,
       u.tablespace,
       sum(u.blocks*p.value/1024/1024) mbused ,
       sum(u.extents) noexts, 
       u.segtype,
       s.module || ' - ' || s.program proginfo
from v$sort_usage u, v$session s, v$parameter p
where u.session_addr = s.saddr
and p.name = 'db_block_size'
group by s.sid,s.status,s.sql_hash_value,u.sqlhash,s.username,u.tablespace,
         u.segtype,
         s.module || ' - ' || s.program
order by 7 desc,3)
where rownum < 90;


