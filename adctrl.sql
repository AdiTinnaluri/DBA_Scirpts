REM @(#)adctrl.sql      2.0
REM
REM Art Varrassi
REM 03/17/09

prompt WORKER STATUS            (FND_INSTALL_PROCESSES)
set feedback off
clear col
col worker_id   format 999900 heading 'WORKER'
col filehead    format a24 heading 'PROGRAM'
col starttime   format a19 heading 'START TIME'
col restarttime format a19 heading 'START TIME'
col endtime     format a19 heading 'END TIME'
col phase       format a10 heading 'PHASE'
col statuscode  format a15 heading 'STATUS'
col restarts    format 99999900 heading 'RESTARTS'
select worker_id, 
       decode(status,'W',null,filename) filehead,
       to_char(restart_time, 'mm/dd/yyyy hh24:mi:ss') restarttime,
       decode(status,'F',to_char(end_time, 'mm/dd/yyyy hh24:mi:ss'),
                     'W',to_char(end_time, 'mm/dd/yyyy hh24:mi:ss'), 
                      null) endtime,
       decode(status,'R','Running','F','Failed','Y','Restarted','W','Wait',null) statuscode,
       decode(status,'W',null,phase_name) phase,
       restart_count    
  from applsys.fnd_install_processes 
where worker_id != 0
  and control_code = 'R'
  and status in ('R','F','Y','W')
 order by 1
/
prompt
clear computes
clear breaks
clear col
set feedback on

