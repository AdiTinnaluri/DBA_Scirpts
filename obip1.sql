set timing on
BEGIN DBMS_STATS.GATHER_TABLE_STATS(ownname => 'FBI_DW',tabname => 'WC_GL_BALANCE_RT_A_10_PRT',estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO',cascade => TRUE,degree =>8);END;
BEGIN DBMS_STATS.GATHER_TABLE_STATS(ownname => 'FBI_DW',tabname => 'WC_INT_ORG_DH_PRT',estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO',cascade => TRUE,degree =>8);END;
BEGIN DBMS_STATS.GATHER_TABLE_STATS(ownname => 'FBI_DW',tabname => 'WC_MCAL_CONTEXT_G',estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO',cascade => TRUE,degree =>8);END;
BEGIN DBMS_STATS.GATHER_TABLE_STATS(ownname => 'FBI_DW',tabname => 'WC_SEG5_HIER_D',estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO',cascade => TRUE,degree =>8);END;
BEGIN DBMS_STATS.GATHER_TABLE_STATS(ownname => 'FBI_DW',tabname => 'W_GL_SEGMENT_D_TL',estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO',cascade => TRUE,degree =>8);END;
BEGIN DBMS_STATS.GATHER_TABLE_STATS(ownname => 'FBI_DW',tabname => 'W_PROFIT_CENTER_D',estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO',cascade => TRUE,degree =>8);END; 
