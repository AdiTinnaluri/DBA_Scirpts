set lines 200;
col SID for 9999;
col INST_ID for 99;
col USERNAME for a07;
col MODULE for a20;
col ACTION for a30;
col EVENT for a30;
col TERMINAL for a10;
SELECT SID, serial#,INST_ID,USERNAME,event,action,logon_time,LAST_CALL_ET/3600, STATUS,SQL_ADDRESS,SQL_HASH_VALUE FROM gv$session WHERE sid=&a;
