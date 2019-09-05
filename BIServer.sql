WITH SAWITH0 AS
  (SELECT SUM(T558752.INV_DIST_AMT)     AS c1,
    SUM(T558752.INV_DIST_LOC_AMT)       AS c2,
    T1271507.ORG_NAME                   AS c3,
    T1271500.ORG_NAME                   AS c4,
    T1271493.ORG_NAME                   AS c5,
    T1210090.BUSN_LOC_NAME              AS c6,
    T549194.X_GLIN                      AS c7,
    T549194.X_SITE_ID                   AS c8,
    T489840.ACCOUNT_SEG5_CODE           AS c10,
    T489840.ACCOUNT_SEG2_CODE           AS c12,
    T489840.ACCOUNT_SEG4_CODE           AS c14,
    T489840.ACCOUNT_SEG3_CODE           AS c15,
    T558752.X_INVOICE_CREATED_DT        AS c16,
    T481081.DAY_DT                      AS c17,
    T558752.PURCH_INVOICE_DIST          AS c18,
    T558752.X_INVOICE_ID                AS c19,
    T558752.PURCH_INVOICE_LINE          AS c20,
    T558752.PURCH_INVOICE_NUM           AS c21,
    T558752.X_INV_REFERENCE_FIELD       AS c22,
    T558752.X_REFERENCE_FIELD_FOR_IT    AS c23,
    T558752.ITEM_DESCRIPTION            AS c24,
    T558752.PURCH_ORDER_NUM             AS c25,
    T558752.X_SUPPLIER_PART_NUM         AS c26,
    T544736.MCAL_PERIOD_NAME            AS c27,
    T1009394.W_STATUS_CODE              AS c28,
    T1009374.XACT_TYPE_CODE             AS c29,
    T549194.X_OWNERSHIP_TYPE            AS c30,
    T558752.X_PURCH_RQSTN_NUM           AS c31,
    T491193.SPLR_ACCT_NAME              AS c32,
    T491193.SPLR_ACCT_NUM               AS c33,
    T549374.X_HIER8_SORT_CODE           AS c34,
    T549374.X_HIER7_SORT_CODE           AS c35,
    T549374.X_HIER6_SORT_CODE           AS c36,
    T481081.ROW_WID                     AS c37,
    T549374.ORG_HIER6_NUM               AS c38,
    T489840.ACCOUNT_SEG3_INTEGRATION_ID AS c39,
    T489840.DATASOURCE_NUM_ID           AS c40,
    T489840.ACCOUNT_SEG5_INTEGRATION_ID AS c42,
    T489840.ACCOUNT_SEG2_INTEGRATION_ID AS c44,
    T489840.ACCOUNT_SEG4_INTEGRATION_ID AS c46
  FROM W_LEDGER_D T1001814
    /* Dim_W_LEDGER_D_Ledger */
    ,
    W_XACT_TYPE_D T1009374
    /* Dim_W_XACT_TYPE_D_AP_Invoice */
    ,
    W_INT_ORG_DH_RPD T549374
    /* Dim_W_INT_ORG_DH_Site_Hierarchy */
    ,
    (SELECT
      /*+ FULL(W_INT_ORG_D_TL) */
      DATASOURCE_NUM_ID,
      INTEGRATION_ID,
      ORG_DESCR,
      ORG_NAME,
      LANGUAGE_CODE
    FROM W_INT_ORG_D_TL
    WHERE LANGUAGE_CODE = 'US'
    ) T1271458,
    (SELECT
      /*+ FULL(W_INT_ORG_D_TL) */
      DATASOURCE_NUM_ID,
      INTEGRATION_ID,
      ORG_DESCR,
      ORG_NAME,
      LANGUAGE_CODE
    FROM W_INT_ORG_D_TL
    WHERE LANGUAGE_CODE = 'US'
    ) T1271493,
    (SELECT
      /*+ FULL(W_INT_ORG_D_TL) */
      DATASOURCE_NUM_ID,
      INTEGRATION_ID,
      ORG_DESCR,
      ORG_NAME,
      LANGUAGE_CODE
    FROM W_INT_ORG_D_TL
    WHERE LANGUAGE_CODE = 'US'
    ) T1271500,
    (SELECT
      /*+ FULL(W_INT_ORG_D_TL) */
      DATASOURCE_NUM_ID,
      INTEGRATION_ID,
      ORG_DESCR,
      ORG_NAME,
      LANGUAGE_CODE
    FROM W_INT_ORG_D_TL
    WHERE LANGUAGE_CODE = 'US'
    ) T1271507,
    W_MCAL_DAY_D T544736
    /* Dim_W_MCAL_DAY_D_Invoice_GL_Date_Fiscal_Calendar */
    ,
    WC_SEG5_HIER_D T550760
    /* Dim_WC_SEG5_HIER_D_Segment5_CompanyHier */
    ,
    WC_OPERATING_UNIT_D T557363
    /* Dim_WC_OPERATING_UNIT_D */
    ,
    W_BUSN_LOCATION_D T549194
    /* Dim_W_BUSN_LOCATION_D_Site */
    ,
    (SELECT AUX1_CHANGED_ON_DT,
      AUX2_CHANGED_ON_DT,
      AUX3_CHANGED_ON_DT,
      AUX4_CHANGED_ON_DT,
      BUSN_LOC_DESCR,
      BUSN_LOC_NAME,
      CHANGED_BY_ID,
      CHANGED_ON_DT,
      CREATED_BY_ID,
      CREATED_ON_DT,
      DATASOURCE_NUM_ID,
      ETL_PROC_WID,
      INTEGRATION_ID,
      LANGUAGE_CODE,
      ROW_WID,
      SRC_LANGUAGE_CODE,
      TENANT_ID,
      W_INSERT_DT,
      W_UPDATE_DT,
      X_CUSTOM
    FROM W_BUSN_LOCATION_D_TL
    WHERE LANGUAGE_CODE = 'US'
    ) T1210090,
    W_DAY_D T481081
    /* Dim_W_DAY_D_Common */
    ,
    W_GL_ACCOUNT_D T489840
    /* Dim_W_GL_ACCOUNT_D */
    ,
    W_SUPPLIER_ACCOUNT_D T491193
    /* Dim_W_SUPPLIER_ACCOUNT_D */
    ,
    W_AP_INV_DIST_F_RPD T558752
    /* Fact_W_AP_INV_DIST_F */
    ,
    W_STATUS_D T1005670
    /* Dim_W_STATUS_D_AP_Invoice_Approval_Status */
    ,
    W_STATUS_D T1009394
    /* Dim_W_STATUS_D_AP_Invoice_Payment_Status */
    ,
    WC_AP_INV_HEADER_D T1186264
    /* Dim_WC_AP_INV_HEADER_D */
  WHERE ( T558752.LEDGER_WID            = T1001814.ROW_WID
  AND T544736.ADJUSTMENT_PERIOD_FLG     = 'N'
  AND T544736.MCAL_CAL_WID              = T558752.X_MCAL_CAL_WID
  AND T544736.MCAL_DAY_DT_WID           = T558752.X_GL_INV_HEADER_DT_WID
  AND T550760.X_PROFIT_CENTER_WID       = T558752.PROFIT_CENTER_WID
  AND T557363.ROW_WID                   = T558752.OPERATING_UNIT_ORG_WID
  AND T549194.DATASOURCE_NUM_ID         = T1210090.DATASOURCE_NUM_ID
  AND T549194.INTEGRATION_ID            = T1210090.INTEGRATION_ID
  AND T549194.X_COST_CENTER_WID         = T558752.COST_CENTER_WID
  AND T481081.ROW_WID                   = T558752.INVOICED_ON_DT_WID
  AND T489840.ROW_WID                   = T558752.GL_ACCOUNT_WID
  AND T491193.ROW_WID                   = T558752.SPLR_ACCT_WID
  AND T558752.INVOICE_TYPE_WID          = T1009374.ROW_WID
  AND T558752.PAYMENT_STATUS_WID        = T1009394.ROW_WID
  AND T558752.APPROVAL_STATUS_WID       = T1005670.ROW_WID
  AND T549374.DATASOURCE_NUM_ID         = T1271458.DATASOURCE_NUM_ID
  AND T549374.ORG_HIER13_NUM            = T1271458.INTEGRATION_ID
  AND T549374.ORG_HIER7_NUM             = T1271500.INTEGRATION_ID
  AND T549374.DATASOURCE_NUM_ID         = T1271500.DATASOURCE_NUM_ID
  AND T549374.ORG_HIER6_NUM             = T1271493.INTEGRATION_ID
  AND T549374.DATASOURCE_NUM_ID         = T1271493.DATASOURCE_NUM_ID
  AND T549374.X_COST_CENTER_WID         = T558752.COST_CENTER_WID
  AND T549374.ORG_HIER8_NUM             = T1271507.INTEGRATION_ID
  AND T549374.DATASOURCE_NUM_ID         = T1271507.DATASOURCE_NUM_ID
  AND T489840.ACCOUNT_SEG5_CODE         = '00300'
  AND T544736.MCAL_PERIOD_NAME          = 'OCT-15'
  AND T549194.ACTIVE_FLG                = 'Y'
  AND T550760.X_HIER1_CODE              = 'T~Total'
  AND T557363.ORG_NAME                  = 'McDonalds US Operating Unit'
  AND T558752.DELETE_FLG                = 'N'
  AND T558752.X_AP_INV_HEADER_WID       = T1186264.ROW_WID
  AND T1001814.LEDGER_NAME              = 'MCD_US'
  AND T1186264.INV_STATUS_CODE          = 'VALIDATED'
  AND T1271458.ORG_NAME                 = 'MBS'
  AND T558752.COST_CENTER_WID          <> 0
  AND (T549374.HIERARCHY_NAME          IN ('MCD Operational Hierarchy', 'MCD Organizational Hierarchy'))
  AND (T1005670.ROW_WID                IN (0)
  OR T1005670.W_STATUS_CLASS           IN ('AP_INVOICE_DISTRIBUTION_APPROVAL'))
  AND (T1009374.ROW_WID                IN (0)
  OR T1009374.W_XACT_CODE              IN ('PAYABLES'))
  AND (T557363.ORG_NUM                 IN ('142', '46996', '74529', '82475', '82499'))
  AND (T491193.X_OPERATING_UNIT_ORG_ID IN ('142', '46996', '74529', '82475', '82499')
  OR T491193.X_OPERATING_UNIT_ORG_ID   IS NULL)
  AND (T1001814.INTEGRATION_ID         IN ('1001', '3021', '3042', '3081', '3084'))
  AND (T1009374.ROW_WID                IN (0)
  OR T1009374.W_XACT_TYPE_CODE         IN ('ORIGINAL'))
  AND (T1009394.ROW_WID                IN (0)
  OR T1009394.W_STATUS_CLASS           IN ('AP_INVOICE_PAYMENT'))
  AND (T549194.X_BUSINESS_GROUP_ID     IN ('101', '46994', '74509', '82435', '82436')
  OR T549194.X_BUSINESS_GROUP_ID       IS NULL)
  AND T1005670.STATUS_CODE             <> 'CANCELLED' )
  GROUP BY T481081.ROW_WID,
    T481081.DAY_DT,
    T489840.DATASOURCE_NUM_ID,
    T489840.ACCOUNT_SEG2_CODE,
    T489840.ACCOUNT_SEG3_CODE,
    T489840.ACCOUNT_SEG4_CODE,
    T489840.ACCOUNT_SEG5_CODE,
    T489840.ACCOUNT_SEG2_INTEGRATION_ID,
    T489840.ACCOUNT_SEG3_INTEGRATION_ID,
    T489840.ACCOUNT_SEG4_INTEGRATION_ID,
    T489840.ACCOUNT_SEG5_INTEGRATION_ID,
    T491193.SPLR_ACCT_NUM,
    T491193.SPLR_ACCT_NAME,
    T544736.MCAL_PERIOD_NAME,
    T549194.X_GLIN,
    T549194.X_SITE_ID,
    T549194.X_OWNERSHIP_TYPE,
    T549374.ORG_HIER6_NUM,
    T549374.ORG_HIER7_NUM,
    T549374.ORG_HIER8_NUM,
    T549374.X_HIER6_SORT_CODE,
    T549374.X_HIER8_SORT_CODE,
    T549374.X_HIER7_SORT_CODE,
    T558752.PURCH_ORDER_NUM,
    T558752.PURCH_INVOICE_NUM,
    T558752.PURCH_INVOICE_LINE,
    T558752.PURCH_INVOICE_DIST,
    T558752.ITEM_DESCRIPTION,
    T558752.X_INVOICE_ID,
    T558752.X_REFERENCE_FIELD_FOR_IT,
    T558752.X_SUPPLIER_PART_NUM,
    T558752.X_PURCH_RQSTN_NUM,
    T558752.X_INVOICE_CREATED_DT,
    T558752.X_INV_REFERENCE_FIELD,
    T1009374.XACT_TYPE_CODE,
    T1009394.W_STATUS_CODE,
    T1210090.BUSN_LOC_NAME,
    T1271493.ORG_NAME,
    T1271500.ORG_NAME,
    T1271507.ORG_NAME
  ),
  OBICOMMON0 AS
  (SELECT T977045.Segment_Description AS c1,
    T977045.Segment_ID                AS c2,
    T977045.Segment_Source_ID         AS c3
  FROM
    (SELECT INTEGRATION_ID AS Segment_ID,
      LANGUAGE_CODE        AS Segment_Language_Code,
      DATASOURCE_NUM_ID    AS Segment_Source_ID,
      SEGMENT_VAL_NAME     AS Segment_Name,
      SEGMENT_VAL_DESCR    AS Segment_Description
    FROM W_GL_SEGMENT_D_TL
    ) T977045
  WHERE ( T977045.Segment_Language_Code = 'US' )
  ),
  SAWITH1 AS
  (SELECT D1.c1 AS c1,
    D1.c2       AS c2,
    D1.c3       AS c3,
    D1.c4       AS c4,
    D1.c5       AS c5,
    D1.c6       AS c6,
    D1.c7       AS c7,
    D1.c8       AS c8,
    D2.c1       AS c9,
    D1.c10      AS c10,
    D3.c1       AS c11,
    D1.c12      AS c12,
    D4.c1       AS c13,
    D1.c14      AS c14,
    D1.c15      AS c15,
    D1.c16      AS c16,
    D1.c17      AS c17,
    D1.c18      AS c18,
    D1.c19      AS c19,
    D1.c20      AS c20,
    D1.c21      AS c21,
    D1.c22      AS c22,
    D1.c23      AS c23,
    D1.c24      AS c24,
    D1.c25      AS c25,
    D1.c26      AS c26,
    D1.c27      AS c27,
    D1.c28      AS c28,
    D1.c29      AS c29,
    D1.c30      AS c30,
    D1.c31      AS c31,
    D1.c32      AS c32,
    D1.c33      AS c33,
    D1.c34      AS c34,
    D1.c35      AS c35,
    D1.c36      AS c36,
    D1.c37      AS c37,
    D1.c38      AS c38,
    D1.c39      AS c39,
    D1.c40      AS c40
  FROM ( ( SAWITH0 D1
  INNER JOIN OBICOMMON0 D2
  ON D1.c40  = D2.c3
  AND D1.c42 = D2.c2)
  INNER JOIN OBICOMMON0 D3
  ON D1.c40  = D3.c3
  AND D1.c44 = D3.c2)
  INNER JOIN OBICOMMON0 D4
  ON D1.c40  = D4.c3
  AND D1.c46 = D4.c2
  ),
  SAWITH2 AS
  (SELECT 0 AS c1,
    D1.c3   AS c2,
    D1.c4   AS c3,
    D1.c5   AS c4,
    D1.c6   AS c5,
    D1.c7   AS c6,
    D1.c8   AS c7,
    D1.c9   AS c8,
    D1.c10  AS c9,
    D1.c11  AS c10,
    D1.c12  AS c11,
    D1.c13  AS c12,
    D1.c14  AS c13,
    D1.c15  AS c14,
    D1.c16  AS c15,
    D1.c17  AS c16,
    D1.c18  AS c17,
    D1.c19  AS c18,
    D1.c20  AS c19,
    D1.c21  AS c20,
    D1.c22  AS c21,
    D1.c23  AS c22,
    D1.c24  AS c23,
    D1.c25  AS c24,
    D1.c26  AS c25,
    D1.c27  AS c26,
    D1.c28  AS c27,
    D1.c29  AS c28,
    D1.c30  AS c29,
    D1.c31  AS c30,
    D1.c32  AS c31,
    D1.c33  AS c32,
    D1.c34  AS c33,
    D1.c35  AS c34,
    D1.c36  AS c35,
    D1.c2   AS c36,
    D1.c1   AS c37,
    D1.c37  AS c40,
    D1.c38  AS c41,
    D1.c39  AS c42,
    D1.c40  AS c43
  FROM SAWITH1 D1
  ),
  SAWITH3 AS
  (SELECT T990840.SEGMENT_VAL_DESCR AS c1,
    T990840.INTEGRATION_ID          AS c2,
    T990840.DATASOURCE_NUM_ID       AS c3
  FROM W_GL_SEGMENT_D_TL T990840
    /* Lookup_W_GL_SEGMENT_D_TL */
  WHERE ( T990840.LANGUAGE_CODE = 'US' )
  ),
  SAWITH4 AS
  (SELECT D1.c1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    AS c1,
    D1.c2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c2,
    D1.c3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c3,
    D1.c4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c4,
    D1.c5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c5,
    D1.c6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c6,
    D1.c7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c7,
    D1.c8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c8,
    D1.c9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c9,
    D1.c10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c10,
    D1.c11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c11,
    D1.c12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c12,
    D1.c13                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c13,
    D2.c1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS c14,
    D1.c14                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c15,
    D1.c15                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c16,
    D1.c16                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c17,
    D1.c17                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c18,
    D1.c18                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c19,
    D1.c19                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c20,
    D1.c20                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c21,
    D1.c21                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c22,
    D1.c22                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c23,
    D1.c23                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c24,
    D1.c24                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c25,
    D1.c25                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c26,
    D1.c26                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c27,
    D1.c27                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c28,
    D1.c28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c29,
    D1.c29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c30,
    D1.c30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c31,
    D1.c31                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c32,
    D1.c32                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c33,
    D1.c33                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c34,
    D1.c34                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c35,
    D1.c35                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c36,
    D1.c36                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c37,
    D1.c37                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c38,
    D1.c40                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c41,
    D1.c41                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c42,
    D1.c42                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c43,
    D1.c43                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS c44,
    ROW_NUMBER() OVER (PARTITION BY D1.c9, D1.c8, D1.c12, D1.c10, D1.c13, D1.c14, D1.c11, D1.c16, D1.c40, D1.c6, D1.c7, D1.c26, D1.c41, D1.c33, D1.c2, D1.c34, D1.c3, D1.c35, D1.c4, D1.c23, D1.c31, D1.c20, D1.c19, D1.c17, D1.c24, D1.c28, D1.c29, D1.c27, D1.c18, D1.c32, D1.c15, D1.c21, D1.c22, D1.c25, D1.c30, D1.c5, D2.c1 ORDER BY D1.c9 DESC, D1.c8 DESC, D1.c12 DESC, D1.c10 DESC, D1.c13 DESC, D1.c14 DESC, D1.c11 DESC, D1.c16 DESC, D1.c40 DESC, D1.c6 DESC, D1.c7 DESC, D1.c26 DESC, D1.c41 DESC, D1.c33 DESC, D1.c2 DESC, D1.c34 DESC, D1.c3 DESC, D1.c35 DESC, D1.c4 DESC, D1.c23 DESC, D1.c31 DESC, D1.c20 DESC, D1.c19 DESC, D1.c17 DESC, D1.c24 DESC, D1.c28 DESC, D1.c29 DESC, D1.c27 DESC, D1.c18 DESC, D1.c32 DESC, D1.c15 DESC, D1.c21 DESC, D1.c22 DESC, D1.c25 DESC, D1.c30 DESC, D1.c5 DESC, D2.c1 DESC) AS c45
  FROM SAWITH2 D1
  INNER JOIN SAWITH3 D2
  ON D1.c42  = D2.c2
  AND D1.c43 = D2.c3
  ),
  SAWITH5 AS
  (SELECT DISTINCT D1.c1 AS c1,
    D1.c2                AS c2,
    D1.c3                AS c3,
    D1.c4                AS c4,
    D1.c5                AS c5,
    D1.c6                AS c6,
    D1.c7                AS c7,
    D1.c8                AS c8,
    D1.c9                AS c9,
    D1.c10               AS c10,
    D1.c11               AS c11,
    D1.c12               AS c12,
    D1.c13               AS c13,
    D1.c14               AS c14,
    D1.c15               AS c15,
    D1.c16               AS c16,
    D1.c17               AS c17,
    D1.c18               AS c18,
    D1.c19               AS c19,
    D1.c20               AS c20,
    D1.c21               AS c21,
    D1.c22               AS c22,
    D1.c23               AS c23,
    D1.c24               AS c24,
    D1.c25               AS c25,
    D1.c26               AS c26,
    D1.c27               AS c27,
    D1.c28               AS c28,
    D1.c29               AS c29,
    D1.c30               AS c30,
    D1.c31               AS c31,
    D1.c32               AS c32,
    D1.c33               AS c33,
    D1.c34               AS c34,
    D1.c35               AS c35,
    D1.c36               AS c36,
    D1.c37               AS c37,
    D1.c38               AS c38,
    D1.c39               AS c39,
    D1.c40               AS c40,
    D1.c41               AS c41,
    D1.c42               AS c42,
    D1.c43               AS c43,
    D1.c44               AS c44
  FROM
    (SELECT D1.c1 AS c1,
      D1.c2       AS c2,
      D1.c3       AS c3,
      D1.c4       AS c4,
      D1.c5       AS c5,
      D1.c6       AS c6,
      D1.c7       AS c7,
      D1.c8       AS c8,
      D1.c9       AS c9,
      D1.c10      AS c10,
      D1.c11      AS c11,
      D1.c12      AS c12,
      D1.c13      AS c13,
      D1.c14      AS c14,
      D1.c15      AS c15,
      D1.c16      AS c16,
      D1.c17      AS c17,
      D1.c18      AS c18,
      D1.c19      AS c19,
      D1.c20      AS c20,
      D1.c21      AS c21,
      D1.c22      AS c22,
      D1.c23      AS c23,
      D1.c24      AS c24,
      D1.c25      AS c25,
      D1.c26      AS c26,
      D1.c27      AS c27,
      D1.c28      AS c28,
      D1.c29      AS c29,
      D1.c30      AS c30,
      D1.c31      AS c31,
      D1.c32      AS c32,
      D1.c33      AS c33,
      D1.c34      AS c34,
      D1.c35      AS c35,
      D1.c36      AS c36,
      D1.c37      AS c37,
      D1.c38      AS c38,
      SUM(
      CASE D1.c45
        WHEN 1
        THEN D1.c37
        ELSE NULL
      END ) over () AS c39,
      SUM(
      CASE D1.c45
        WHEN 1
        THEN D1.c38
        ELSE NULL
      END ) over ()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       AS c40,
      D1.c41                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              AS c41,
      D1.c42                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              AS c42,
      D1.c43                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              AS c43,
      D1.c44                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              AS c44,
      ROW_NUMBER() OVER (PARTITION BY D1.c2, D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10, D1.c11, D1.c12, D1.c13, D1.c14, D1.c15, D1.c16, D1.c17, D1.c18, D1.c19, D1.c20, D1.c21, D1.c22, D1.c23, D1.c24, D1.c25, D1.c26, D1.c27, D1.c28, D1.c29, D1.c30, D1.c31, D1.c32, D1.c33, D1.c34, D1.c35, D1.c36, D1.c41, D1.c42, D1.c43, D1.c44 ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c4 ASC, D1.c5 ASC, D1.c6 ASC, D1.c7 ASC, D1.c8 ASC, D1.c9 ASC, D1.c10 ASC, D1.c11 ASC, D1.c12 ASC, D1.c13 ASC, D1.c14 ASC, D1.c15 ASC, D1.c16 ASC, D1.c17 ASC, D1.c18 ASC, D1.c19 ASC, D1.c20 ASC, D1.c21 ASC, D1.c22 ASC, D1.c23 ASC, D1.c24 ASC, D1.c25 ASC, D1.c26 ASC, D1.c27 ASC, D1.c28 ASC, D1.c29 ASC, D1.c30 ASC, D1.c31 ASC, D1.c32 ASC, D1.c33 ASC, D1.c34 ASC, D1.c35 ASC, D1.c36 ASC, D1.c41 ASC, D1.c42 ASC, D1.c43 ASC, D1.c44 ASC) AS c45
    FROM SAWITH4 D1
    ) D1
  WHERE ( D1.c45 = 1 )
  )
SELECT D1.c1 AS c1,
  D1.c2      AS c2,
  D1.c3      AS c3,
  D1.c4      AS c4,
  D1.c5      AS c5,
  D1.c6      AS c6,
  D1.c7      AS c7,
  D1.c8      AS c8,
  D1.c9      AS c9,
  D1.c10     AS c10,
  D1.c11     AS c11,
  D1.c12     AS c12,
  D1.c13     AS c13,
  D1.c14     AS c14,
  D1.c15     AS c15,
  D1.c16     AS c16,
  D1.c17     AS c17,
  D1.c18     AS c18,
  D1.c19     AS c19,
  D1.c20     AS c20,
  D1.c21     AS c21,
  D1.c22     AS c22,
  D1.c23     AS c23,
  D1.c24     AS c24,
  D1.c25     AS c25,
  D1.c26     AS c26,
  D1.c27     AS c27,
  D1.c28     AS c28,
  D1.c29     AS c29,
  D1.c30     AS c30,
  D1.c31     AS c31,
  D1.c32     AS c32,
  D1.c33     AS c33,
  D1.c34     AS c34,
  D1.c35     AS c35,
  D1.c36     AS c36,
  D1.c37     AS c37,
  D1.c38     AS c38,
  D1.c39     AS c39,
  D1.c40     AS c40
FROM
  (SELECT D1.c1 AS c1,
    D1.c2       AS c2,
    D1.c3       AS c3,
    D1.c4       AS c4,
    D1.c5       AS c5,
    D1.c6       AS c6,
    D1.c7       AS c7,
    D1.c8       AS c8,
    D1.c9       AS c9,
    D1.c10      AS c10,
    D1.c11      AS c11,
    D1.c12      AS c12,
    D1.c13      AS c13,
    D1.c14      AS c14,
    D1.c15      AS c15,
    D1.c16      AS c16,
    D1.c17      AS c17,
    D1.c18      AS c18,
    D1.c19      AS c19,
    D1.c20      AS c20,
    D1.c21      AS c21,
    D1.c22      AS c22,
    D1.c23      AS c23,
    D1.c24      AS c24,
    D1.c25      AS c25,
    D1.c26      AS c26,
    D1.c27      AS c27,
    D1.c28      AS c28,
    D1.c29      AS c29,
    D1.c30      AS c30,
    D1.c31      AS c31,
    D1.c32      AS c32,
    D1.c33      AS c33,
    D1.c34      AS c34,
    D1.c35      AS c35,
    D1.c36      AS c36,
    D1.c37      AS c37,
    D1.c38      AS c38,
    D1.c39      AS c39,
    D1.c40      AS c40
  FROM SAWITH5 D1
  ORDER BY c1,
    c17 DESC,
    c27,
    c19,
    c21,
    c20,
    c18,
    c22,
    c23,
    c31,
    c25,
    c33,
    c32,
    c34,
    c35,
    c36,
    c6,
    c5,
    c7,
    c9,
    c8,
    c30,
    c11,
    c15,
    c13,
    c10,
    c14,
    c12,
    c16,
    c24,
    c26,
    c29,
    c28
  ) D1
WHERE rownum <= 65001
/

