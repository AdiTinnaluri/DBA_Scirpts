set lines 180
column oracle_process_id     format A8 
column request_id            format 9999999999
column conc_prog_name        format A40
column requestor             format A20

select fcr.request_id,
substr(decode (fcr.description, null, fcp.user_concurrent_program_name,     fcr.description||' ('||fcp.user_concurrent_program_name||')'),1,40) conc_prog_name,
  to_char(fcr.actual_start_date,'hh24:mi') s_time,
       fu.user_name requestor
       , sid
       , vs.process
       , vp.spid
--       , fcr.oracle_process_id
from
     v$session vs,
     v$process vp,
     apps.fnd_user fu,
     apps.fnd_concurrent_programs_vl fcp,
     apps.fnd_concurrent_requests fcr
where fcp.concurrent_program_id = fcr.concurrent_program_id
and fcr.program_application_id = fcp.application_id
and fcr.status_code = 'R'
and fcr.phase_code = 'R'
and fcr.requested_by = fu.user_id
and fcr.oracle_process_id = vp.spid(+)
and vp.addr = vs.paddr (+)
order by substr(decode (fcr.description, null, fcp.user_concurrent_program_name,     fcr.description||' ('||fcp.user_concurrent_program_name||')'),1,40), fcr.actual_start_date
;

