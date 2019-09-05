SPOOL who_login
SET pages 1000
SET linesize 140

COLUMN osuser format a8 heading 'OS User'
COLUMN process format 9999999 on heading 'Form Serv|Parent|PID'   
COLUMN ora_process format 9999999  on heading 'DB Serv|Process|PID'       
COLUMN user_name format a11 trunc heading 'App|Login|Name'
COLUMN email_address format a11 trunc heading 'Name'
COLUMN Nbr_connects format 999  heading 'Nbr|Conns'   
COLUMN login_time format a12 trunc heading 'Login Time'
COLUMN program format a12 trunc heading 'Program'

BREAK ON user_name
ttitle 'Users logged into Oracle Application mapped to Processes'

SELECT 
         fu.user_name
,        fu.email_address
,        COUNT(1) Nbr_connects
,        p.spid ora_process
,        s.process
,        TO_CHAR(fl.start_time, 'dd-Mon hh24:mi') login_time
,        s.program
FROM
      apps.fnd_user   fu
,     apps.fnd_logins fl
,     v$session       s
,     v$process       p
WHERE 1=1
AND fl.end_time       IS NULL        /* only show currently logged in users */
AND   fl.user_id      = fu.user_id(+)
AND   fl.process_spid = p.spid
AND   fl.pid          = p.pid
AND   fl.serial#      = p.serial#
AND   p.addr          = s.paddr
GROUP BY
      fu.user_name
,     fu.email_address
,     p.spid
,     s.process
,     TO_CHAR(fl.start_time, 'dd-Mon hh24:mi')
,     fl.login_name
,     fl.end_time
,     s.program
ORDER BY fu.user_name
,        TO_CHAR(fl.start_time, 'dd-Mon hh24:mi');
