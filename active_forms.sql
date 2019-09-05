set lines 155

col user_name heading 'User|ID' form a6
col description heading 'User Name' form a20
col email_address heading 'Email Address' form a21 trunc
col responsibility_name heading 'Responsibility' form a25 wrap
col form_name heading 'Form|Short Name' form a10 trunc
col user_form_name heading 'Form Name' form a30 trunc
col spid heading 'Server|PID' form a6
col sql_hash_value heading 'Current|Hash Value' form 99999999999
col sid_serial heading 'SID|Serial#' form a12
col minutes heading 'Minutes' form 99,999.0
col logon_time heading "Logon Time" form a18


def aps_prog    = 'aaforms.sql'
def aps_title   = 'ACTIVE Forms Information (Ordered by SID)'

start apstitle

SELECT distinct --l.login_id,
       fu.user_name,fu.description,--substr(fu.EMAIL_ADDRESS,1,20)||' ' email_address,
       frt.responsibility_name,
       fft.user_form_name,
       ff.form_name,
       lpad(to_char(s.logon_time,'dd-mon-yy hh24:Mi:SS'),18) logon_time,
--       (sysdate-s.logon_time)*24*60 minutes,
       substr(lpad(s.sid,4)||','||s.serial#,1,15) sid_serial,p.spid,s.sql_hash_value
  FROM FND_USER fu,
       FND_LOGINS fl,
       FND_RESPONSIBILITY_TL frt,
       FND_LOGIN_RESPONSIBILITIES flr,
       FND_LOGIN_RESP_FORMS flrf,
       FND_FORM ff,
       FND_FORM_TL fft,
       v$session s,
       v$process p,
       (SELECT MAX(fl_2.login_id) login_id,fl_2.spid
         FROM fnd_logins fl_2,
              v$session s_2,
              v$process p_2
        WHERE s_2.paddr=p_2.addr
          AND s_2.action like 'Online%'
          AND p_2.spid=fl_2.process_spid
          AND p_2.pid=fl_2.pid
          AND s_2.status='ACTIVE'
        GROUP BY fl_2.spid
       ) l
 WHERE fl.login_id=l.login_id
   AND flr.login_id=l.login_id
   AND flrf.login_id = l.login_id
   AND fl.process_spid=p.spid
   AND fl.pid=p.pid
   AND s.paddr=p.addr
   AND fu.user_id=fl.user_id
   AND frt.responsibility_id=flr.responsibility_id
   AND frt.application_id = flr.resp_appl_id
   and flr.end_time is null
   AND fft.form_id = flrf.form_id 
   AND fft.application_id = flrf.FORM_APPL_ID
   AND ff.application_id = fft.application_id 
   AND ff.form_id = fft.form_id 
 ORDER BY sid_serial
/

start apsclear


