set pages 1000 lines 260
col SCEN_NAME for a30
alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
 select DISTINCT SNP_LP_INST.I_LP_INST,
SNP_SESSION.sess_no, SNP_SESSION.scen_name,
--TO_CHAR(SNP_SESSION.sess_beg, 'dd-mon-yyyy HH24:MI:SS') 
SNP_SESSION.sess_beg sess_beg, SNP_SESSION.sess_end, SNP_SESSION.sess_dur, 
ROUND(SNP_SESSION.sess_dur/60,2) sess_dur_mins,
SNP_SESSION.sess_status, 
SNP_SESSION.nb_row, SNP_SESSION.nb_ins, SNP_SESSION.nb_upd
from FBI_BIA_ODIREPO.SNP_LOAD_PLAN, 
FBI_BIA_ODIREPO.SNP_LP_INST, 
FBI_BIA_ODIREPO.SNP_LPI_STEP_LOG, 
FBI_BIA_ODIREPO.SNP_SESSION
where 1=1
and SNP_LOAD_PLAN.I_LOAD_PLAN = SNP_LP_INST.I_LOAD_PLAN
and SNP_LP_INST.I_LP_INST = SNP_LPI_STEP_LOG.I_LP_INST
and SNP_LPI_STEP_LOG.SESS_NO = SNP_SESSION.SESS_NO
--and SNP_LOAD_PLAN.load_plan_name like '%AP_PO_AR%'
and SNP_SESSION.sess_status='R'
and SNP_SESSION.sess_beg >= TO_DATE('31-dec-2017 04:50:00','DD-MON-YYYY hh24:mi:ss'); 
