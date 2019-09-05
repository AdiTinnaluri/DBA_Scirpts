set pagesize 200;
set lines 2121;
col USERNAME for a10;
col WAIT_CLASS for a15
col EVENT for a28
col MODULE for a41
col ACTION for a21
col SID for 9999
col SERIAL# for 99999999
col INST_ID for 999999
select sid, serial#, action, module, event,status,wait_class,last_call_et,sql_id,inst_id from gv$session where wait_class like '%Conc%';
