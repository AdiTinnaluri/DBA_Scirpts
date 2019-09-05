
set heading on
col name heading "Name" format a40
col max_processes heading "Target" format 999
col running_processes heading "Actual" format 999
col run heading "Running" format 999
col pend heading "Pending" format 9999
col stat heading "Status" format a15
set pagesize 99 lines 200
select a.user_concurrent_queue_name name, a.running_processes, a.max_processes,
nvl(b.running,0) run, nvl(c.pending,0) pend, d.status stat
-- from apps.fnd_concurrent_worker_requests a,
from apps.fnd_concurrent_queues_vl a,
(select concurrent_queue_name, count(*) running
from apps.fnd_concurrent_worker_requests
where phase_code = 'R'
group by concurrent_queue_name ) b,
(select concurrent_queue_name, count(*) pending
from apps.fnd_concurrent_worker_requests
where phase_code = 'P'
and requested_start_date <= sysdate
and status_code in ('Q','I')
and hold_flag= 'N'
group by concurrent_queue_name ) c,
(select concurrent_queue_name, decode(control_code, 'E', 'Deactivated',' ') status
from applsys.fnd_concurrent_queues ) d
where a.concurrent_queue_name = b.concurrent_queue_name (+)
and a.concurrent_queue_name = c.concurrent_queue_name (+)
and a.concurrent_queue_name = d.concurrent_queue_name (+) and a.user_concurrent_queue_name like '%'
and d.status != 'Deactivated'
group by a.user_concurrent_queue_name,  a.max_processes, a.running_processes,
nvl(b.running,0), nvl(c.pending,0), d.status
order by 2 desc; 
