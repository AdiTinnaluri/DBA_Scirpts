 col ETIME for 99999
    col ARGUMENT_TEXT for a50
    set HEADING on
    set pagesize 200
    set linesize 300
    col "Submitted By" for a23
    col USER_CONCURRENT_PROGRAM_NAME for a25
    col ARGUMENT_TEXT for a60
    SELECT distinct t.user_concurrent_program_name, r.REQUEST_ID,
    r.REQUESTED_START_DATE "Requested at",
    to_char(r.ACTUAL_START_DATE,'dd-mm-yy hh24:mi:ss') "Started at",
    to_char(r.ACTUAL_COMPLETION_DATE,'dd-mm-yy hh24:mi:ss') "Completed at",
    decode(r.PHASE_CODE,'C','Completed','I','Inactive','P ','Pending','R','Running','NA') phasecode,
    decode(r.STATUS_CODE, 'A','Waiting', 'B','Resuming', 'C','Normal', 'D','Cancelled', 'E','Error', 'F','Scheduled', 'G','Warning', 'H','On Hold', 'I','Normal', 'M','No     Manager', 'Q','Standby', 'R','Normal', 'S','Suspended', 'T','Terminating', 'U','Disabled', 'W','Paused', 'X','Terminated', 'Z','Waiting') "Status",
    substr(u.description,1,21) "Submitted By",
   r.ARGUMENT_TEXT,
    round(((nvl(v.actual_completion_date,sysdate)-v.actual_start_date)*24*60)) Etime
    FROM apps.fnd_concurrent_requests r , apps.fnd_concurrent_programs p , apps.fnd_concurrent_programs_tl t, apps.fnd_user u, apps.fnd_conc_req_summary_v v
    WHERE  r.CONCURRENT_PROGRAM_ID = p.CONCURRENT_PROGRAM_ID 
    AND r.actual_start_date >= (sysdate-3) --AND r.requested_by=22378
    AND   r.PROGRAM_APPLICATION_ID = p.APPLICATION_ID
    AND t.concurrent_program_id=r.concurrent_program_id
    AND r.REQUESTED_BY=u.user_id
    AND v.request_id=r.request_id
	AND r.request_id='&request_id'
    --AND r.request_id ='2260046' in ('13829387','13850423')
    --and t.user_concurrent_program_name like 'DPI_SBT_852_ORDER_CREATION%'
    --and p.concurrent_program_name like '%Gather%Schema%'
    order by to_char(r.ACTUAL_COMPLETION_DATE,'dd-mm-yy hh24:mi:ss');
