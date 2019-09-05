
                                                                                
  CREATE OR REPLACE PROCEDURE "FBI_DW"."PROC_GL_BALANCE_FACT_UPD_PPE"           
AS                                                                              
  /*                                                                            
  Purpose : This procedure is built to update PPE columns (X_ADDITIONS, X_RETIRE
MENTS, X_TRANSFERS)                                                             
  in GL Balance Table                                                           
  Version : 1.0                                                                 
  Date    : 09/21/14                                                            
  Created by : Maneesh Jain                                                     
  */                                                                            
  VVC_SQLSTMT          VARCHAR2 (5000);                                         
  VVC_ERR_MSG          VARCHAR2 (5000);                                         
  VVC_REC_COUNT        NUMBER := 0;                                             
  CURR_MONTH           NUMBER := 9;                                             
  CURR_MONTH_PARTITION VARCHAR2 (10);                                           
  LAST_MONTH_PARTITION VARCHAR2 (10);                                           
                                                                                
                                                                                
BEGIN                                                                           
	PROC_INFO_LOG('PROC_GL_BALANCE_FACT_UPD_PPE','Start of Proc','Start of Proc'); 
                                                                                
  	LAST_MONTH_PARTITION := 'P_'||TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,     -2)),'
YYYYMMDD');                                                                     
  	CURR_MONTH_PARTITION := 'P_'||TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,     -1)),'
YYYYMMDD');                                                                     
  	CURR_MONTH           := EXTRACT(MONTH FROM LAST_DAY(ADD_MONTHS(SYSDATE,-1)));
                                                                                
                                                                                
        PROC_INFO_LOG ('PROC_GL_BALANCE_FACT_UPD_PPE','Processing Partition: '||
CURR_MONTH_PARTITION,'Processing Partition: '||CURR_MONTH_PARTITION);           
        PROC_INFO_LOG ('PROC_GL_BALANCE_FACT_UPD_PPE','Set PPE columns to zero',
 'Set PPE columns to zero');                                                    
        vvc_sqlstmt := 'UPDATE W_GL_BALANCE_F PARTITION ('||CURR_MONTH_PARTITION
||')                                                                            
        	SET                                                                    
        	X_ADDITIONS = 0,                                                       
        	X_RETIREMENTS = 0,                                                     
        	X_TRANSFERS = 0';                                                      
        EXECUTE IMMEDIATE vvc_sqlstmt;                                          
        VVC_REC_COUNT := SQL%ROWCOUNT;                                          
        PROC_INFO_LOG ('PROC_GL_BALANCE_FACT_UPD_PPE','Set PPE columns to zero f
or '||VVC_REC_COUNT||' Records','Set PPE columns to zero for '||VVC_REC_COUNT||'
 Records');                                                                     
        --PROC_INFO_LOG ('PROC_GL_BALANCE_FACT_UPD_PPE',vvc_sqlstmt,vvc_sqlstmt)
;                                                                               
        COMMIT;                                                                 
        PROC_INFO_LOG('PROC_GL_BALANCE_FACT_UPD_PPE','Updating PPE Columns','Upd
ating PPE Columns');                                                            
        IF (curr_month = 1) THEN                                                
		vvc_sqlstmt := '                                                              
		MERGE /*+ PARALLEL(TGT 8) */ INTO W_GL_BALANCE_F PARTITION ('||CURR_MONTH_PART
ITION||') TGT                                                                   
		USING                                                                         
		(                                                                             
                SELECT GL_ACCOUNT_WID AS GL_ACCOUNT_WID, DB_CR_IND AS DB_CR_IND,
DOC_CURR_CODE,                                                                  
                SUM(X_ADDITIONS) AS X_ADDITIONS,                                
                SUM(X_RETIREMENTS) AS X_RETIREMENTS,                            
                SUM(X_TRANSFERS) AS X_TRANSFERS                                 
                FROM                                                            
                (SELECT /*+ FULL(PREV) PARALLEL(F, 8) */ F.GL_ACCOUNT_WID, DB_CR_IND,DOC_CU
RR_CODE,                                                                        
                USER_JE_CATEGORY_NAME,                                          
                CASE                                                            
                WHEN USER_JE_CATEGORY_NAME NOT IN (''Transfer'', ''Retirement'')
                                                                                
                THEN SUM(F.OTHER_LOC_AMT)                                       
                ELSE 0                                                          
                END X_ADDITIONS,                                                
                CASE                                                            
                WHEN D.USER_JE_CATEGORY_NAME = ''Retirement''                   
                THEN SUM(F.OTHER_LOC_AMT)                                       
                ELSE 0                                                          
                END X_RETIREMENTS,                                              
                CASE                                                            
                WHEN USER_JE_CATEGORY_NAME IN (''Transfer'')                    
                THEN SUM(F.OTHER_LOC_AMT)                                       
                ELSE 0                                                          
                END X_TRANSFERS                                                 
                FROM FBI_DW.w_gl_other_f PARTITION ('||CURR_MONTH_PARTITION||   
                    ') F,                                                       
                FBI_DW.WC_GL_JE_CATEGORY_D D                                    
                WHERE F.X_JEH_JE_CATEGORY_WID = D.ROW_WID                       
                GROUP BY F.GL_Account_wid,DB_CR_IND,DOC_CURR_CODE,              
                USER_JE_CATEGORY_NAME                                           
                )                                                               
                GROUP BY GL_Account_wid,DB_CR_IND, DOC_CURR_CODE) SRC           
                ON (TGT.GL_ACCOUNT_WID = SRC.GL_ACCOUNT_WID AND                 
                TGT.DB_CR_IND = SRC.DB_CR_IND                                   
                AND REPLACE(TGT.ACCT_CURR_CODE, ''NULL'', TGT.LOC_CURR_CODE) = S
RC.DOC_CURR_CODE                                                                
                )                                                               
                WHEN MATCHED THEN UPDATE                                        
                SET                                                             
                TGT.X_ADDITIONS = SRC.X_ADDITIONS,                              
                TGT.X_RETIREMENTS = SRC.X_RETIREMENTS,                          
                TGT.X_TRANSFERS = SRC.X_TRANSFERS';                             
                    EXECUTE IMMEDIATE vvc_sqlstmt;                              
                  VVC_REC_COUNT := SQL%ROWCOUNT;                                
                  PROC_INFO_LOG ('PROC_GL_BALANCE_FACT_UPD_PPE',VVC_REC_COUNT||'
 rows updated',VVC_REC_COUNT||' rows updated');                                 
	ELSE                                                                           
    		vvc_sqlstmt := '                                                          
		MERGE                                                                         
                /*+  PARALLEL(TGT 8) */                                          
                INTO W_GL_BALANCE_F PARTITION ('||CURR_MONTH_PARTITION||') TGT U
SING                                                                            
                (WITH GLBAL AS                                                  
                (SELECT                                                         
                /*+ FULL(PREV) PARALLEL(CURR, 8) PARALLEL(PREV, 8) */                      
                CURR.GL_ACCOUNT_WID,                                            
                CURR.DB_CR_IND, CURR.ACCT_CURR_CODE, CURR.LOC_CURR_CODE,        
                NVL(PREV.X_ADDITIONS,0) X_ADDITIONS,                            
                NVL(PREV.X_RETIREMENTS,0) X_RETIREMENTS,                        
                NVL(PREV.X_TRANSFERS,0) X_TRANSFERS                             
                FROM W_GL_BALANCE_F PARTITION ('||CURR_MONTH_PARTITION||') CURR,
                                                                                
                W_GL_BALANCE_F PARTITION ('||LAST_MONTH_PARTITION||             
                    ') PREV                                                     
                WHERE 1=1                                                       
                AND CURR.GL_ACCOUNT_WID = PREV.GL_ACCOUNT_WID (+)               
                AND CURR.ACCT_CURR_CODE = PREV.ACCT_CURR_CODE (+)               
                AND CURR.DB_CR_IND = PREV.DB_CR_IND (+)                         
                ),                                                              
                GLOTHER AS                                                      
                (SELECT GL_ACCOUNT_WID AS GL_ACCOUNT_WID,                       
                DB_CR_IND            AS DB_CR_IND,                              
                DOC_CURR_CODE,                                                  
                SUM(X_ADDITIONS)   AS X_ADDITIONS,                              
                SUM(X_RETIREMENTS) AS X_RETIREMENTS,                            
                SUM(X_TRANSFERS)   AS X_TRANSFERS                               
                FROM                                                            
                (SELECT                                                         
                /*+ PARALLEL(F, 8) */                                           
                F.GL_ACCOUNT_WID,                                               
                DB_CR_IND,                                                      
                DOC_CURR_CODE,                                                  
                USER_JE_CATEGORY_NAME,                                          
                CASE                                                            
                WHEN USER_JE_CATEGORY_NAME NOT IN (''Transfer'', ''Retirement'')
                                                                                
                THEN SUM(F.OTHER_LOC_AMT)                                       
                ELSE 0                                                          
                END X_ADDITIONS,                                                
                CASE                                                            
                WHEN D.USER_JE_CATEGORY_NAME = ''Retirement''                   
                THEN SUM(F.OTHER_LOC_AMT)                                       
                ELSE 0                                                          
                END X_RETIREMENTS,                                              
                CASE                                                            
                WHEN USER_JE_CATEGORY_NAME IN (''Transfer'')                    
                THEN SUM(F.OTHER_LOC_AMT)                                       
                ELSE 0                                                          
                END X_TRANSFERS                                                 
                FROM FBI_DW.w_gl_other_f PARTITION ('                           
                    ||CURR_MONTH_PARTITION||                                    
                    ') F,                                                       
                FBI_DW.WC_GL_JE_CATEGORY_D D                                    
                WHERE F.X_JEH_JE_CATEGORY_WID = D.ROW_WID                       
                GROUP BY F.GL_Account_wid,                                      
                DB_CR_IND,                                                      
                DOC_CURR_CODE,                                                  
                USER_JE_CATEGORY_NAME                                           
                )                                                               
                GROUP BY GL_Account_wid,                                        
                DB_CR_IND,                                                      
                DOC_CURR_CODE                                                   
                )                                                               
                SELECT GLBAL.GL_ACCOUNT_WID,                                    
                GLBAL.DB_CR_IND,                                                
                GLBAL.ACCT_CURR_CODE,                                           
                NVL(GLBAL.X_ADDITIONS,0)   + NVL(GLOTHER.X_ADDITIONS,0)   AS X_A
DDITIONS,                                                                       
                NVL(GLBAL.X_RETIREMENTS,0) + NVL(GLOTHER.X_RETIREMENTS,0) AS X_R
ETIREMENTS,                                                                     
                NVL(GLBAL.X_TRANSFERS,0)   + NVL(GLOTHER.X_TRANSFERS,0)   AS X_T
RANSFERS                                                                        
                FROM GLBAL,                                                     
                GLOTHER                                                         
                WHERE 1                                          =1             
                AND GLBAL.GL_ACCOUNT_WID                         = GLOTHER.GL_AC
COUNT_WID (+)                                                                   
                AND GLBAL.DB_CR_IND                              = GLOTHER.DB_CR
_IND (+)                                                                        
                AND REPLACE(GLBAL.ACCT_CURR_CODE, ''NULL'', GLBAL.LOC_CURR_CODE)
 = GLOTHER.DOC_CURR_CODE (+)                                                    
                ) SRC ON (TGT.GL_ACCOUNT_WID                                    
                = SRC.GL_ACCOUNT_WID AND TGT.DB_CR_IND = SRC.DB_CR_IND AND TGT.A
CCT_CURR_CODE = SRC.ACCT_CURR_CODE)                                             
                WHEN MATCHED THEN                                               
                UPDATE                                                          
                SET TGT.X_ADDITIONS = SRC.X_ADDITIONS,                          
                TGT.X_RETIREMENTS = SRC.X_RETIREMENTS,                          
                TGT.X_TRANSFERS   = SRC.X_TRANSFERS'                            
                    ;                                                           
                    EXECUTE IMMEDIATE vvc_sqlstmt;                              
                    VVC_REC_COUNT := SQL%ROWCOUNT;                              
                  PROC_INFO_LOG ('PROC_GL_BALANCE_FACT_UPD_PPE',VVC_REC_COUNT||'
 rows updated',VVC_REC_COUNT||' rows updated');                                 
                --    PROC_INFO_LOG ('PROC_GL_BALANCE_FACT_UPD_PPE',vvc_sqlstmt,
vvc_sqlstmt);                                                                   
  	END IF;                                                                      
                                                                                
  	COMMIT;                                                                      
                                                                                
PROC_INFO_LOG('PROC_GL_BALANCE_FACT_UPD_PPE','End of Proc','End of Proc');      
                                                                                
EXCEPTION                                                                       
WHEN OTHERS THEN                                                                
  proc_error_log (0, 'PROC_GL_BALANCE_FACT_UPD_PPE', DBMS_UTILITY.format_error_b
acktrace () || '~' || vvc_sqlstmt || '~' || vvc_err_msg, SQLERRM );             
END PROC_GL_BALANCE_FACT_UPD_PPE;                                               
                                                                                

SQL> spool off
