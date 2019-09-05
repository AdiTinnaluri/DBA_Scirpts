set pagesize 200 feedback on head on
Col User_name   form a15                TRUNC
col request_id  form 999999999          TRUNC
col Time        form a4                 TRUNC
col Program     form a54                TRUNC
col program_id  form 999999             TRUNC
col parent_id   form 999999999          TRUNC
col status      form a17                TRUNC
col Scheduled   form a16                TRUNC
set line 200

select
  /*+ choose */
 U.USER_NAME User_name,
  fcr.request_id request_id,
  to_char(round((nvl(fcr.actual_completion_date,sysdate)-fcr.actual_start_date)*1440)) Time,
  c.concurrent_program_name||' - ' ||
  substr(fcrv.program,1,55) PROGRAM,
  fcr.CONCURRENT_PROGRAM_ID     Program_id,
  fcr.PARENT_REQUEST_ID Parent_id
from
  fnd_concurrent_requests fcr,
  fnd_concurrent_programs c,
  fnd_conc_req_summary_v fcrv,
  fnd_user      U
where
  fcr.concurrent_program_id = c.concurrent_program_id
  and fcr.program_application_id = c.application_id
  and fcr.CONCURRENT_PROGRAM_ID = fcrv.CONCURRENT_PROGRAM_ID
  and fcr.REQUEST_ID = fcrv.REQUEST_ID
  and fcr.phase_code in ('R','T')
  and fcr.requested_by = U.user_id
order by request_id asc
/

