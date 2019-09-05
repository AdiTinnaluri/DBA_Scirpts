alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
set lines 2121
set pages 100   
col "SCEN_NAME" for a25 trunc;
col "LP_STEP_NAME" for a35 trunc;
SELECT DISTINCT LPSL.I_LP_INST,
                  LPSL.I_LP_STEP,
                  LPS.LP_STEP_NAME,
                  LPS.SCEN_NAME,
                  LPSL.START_DATE,
                  LPSL.END_DATE,
                  SNPS.SESS_NO,
                  SNPS.SESS_DUR / 60,
                  SNPS.NB_ROW "ROWS PROCESSED",
                  SNPS.NB_INS "ROWS INSERTED",
                  SNPS.NB_UPD "ROWS UPDATED"
    FROM FBI_BIA_ODIREPO.SNP_LPI_STEP_LOG LPSL,
         FBI_BIA_ODIREPO.SNP_LP_INST     LPI,
         FBI_BIA_ODIREPO.SNP_LPI_STEP    LPS,
         FBI_BIA_ODIREPO.SNP_SESSION     SNPS
   WHERE     LPSL.I_LP_STEP = LPS.I_LP_STEP
         AND LPI.I_LP_INST = LPSL.I_LP_INST
         AND LPSL.SESS_NO = SNPS.SESS_NO(+)
         AND LPS.LP_STEP_TYPE = 'RS'
       --  and LPSL.STATUS ='D'
        -- and LPI.LOAD_PLAN_NAME like  'GLODS_101_20160324_060336%'
       --- and LPS.LP_STEP_NAME like '%W_GL_LINKAGE_INFORMATION_GS%' --in ('Create Indexes : W_POSITION_DH 2/2','Create Indexes : W_POSITION_DH 1/2','Gather Stats : W_POSITION_DH')
       --and LPS.LP_STEP_NAME='PLP_GLBALANCE_AGGREGATE6'
        --and LPS.SCEN_NAME  like ('SDE_ORA_GL_PR_LinkageInformation') -- ,'PLP_APTRANSACTIONAGGLOAD'
        AND LPSL.I_LP_INST IN  (SELECT MAX (I_LP_INST) FROM FBI_BIA_ODIREPO.SNP_LP_INST LPI WHERE load_plan_name ='Custom_MCD_AP_PO_AR_iExpense_PCA_INCR - 1_83_20160308_133243 - INCR'
;
