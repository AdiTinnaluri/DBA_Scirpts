/* showappsid.sql
     show the applications user based on the sid
*/
rem to_char(max(l.start_time),'mm/dd/yy hh:mi:ssAM') startedat, 
set lines 132
set verify off
col user_name head "Apps Signon" format a12 trunc 
col description head "Real Name" format a25 trunc
rem col user_form_name head "Form Name" format a30 trunc
col forminfo head "Form Name" format a40 trunc
col time head "Elapsed Time" format a10
col zoom_level head "Zoom Level" 
col startedat head "Logon At" format a19
col lastcallet format a11
accept trgtsid number prompt 'What is the SID : '
select /*+ rule */
       to_char(s.logon_time,'mm/dd/yy hh:mi:ssAM') startedat, 
       a.time,
       floor(s.last_call_et/3600)||':'||
       floor(mod(s.last_call_et,3600)/60)||':'||
       mod(mod(s.last_call_et,3600),60) "LastCallET",      
       u.user_name, u.description ,
       s.module || ' - ' || a.user_form_name forminfo
  from applsys.fnd_logins l,
       applsys.fnd_user u,
       apps.fnd_signon_audit_view a,
       v$process p,
       v$session s
 where s.sid = &trgtsid
   and s.paddr = p.addr
   and p.pid = l.pid
   and l.end_time is null
   and l.spid = s.process
   and l.start_time is not null
--   and l.start_time = u.last_logon_date
--   and l.session_number = u.session_number
   and l.user_id = u.user_id
   and u.user_id = a.user_id
   and p.pid = a.pid
   and l.start_time = (select max(l2.start_time) 
                         from applsys.fnd_logins l2
                        where l2.pid = l.pid)
group by to_char(s.logon_time,'mm/dd/yy hh:mi:ssAM'),
       floor(s.last_call_et/3600)||':'||
       floor(mod(s.last_call_et,3600)/60)||':'||
       mod(mod(s.last_call_et,3600),60),      
       u.user_name, u.description,a.time,s.module || ' - ' || a.user_form_name
order by to_char(s.logon_time,'mm/dd/yy hh:mi:ssAM'),a.time;



