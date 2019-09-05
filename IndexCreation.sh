sqlplus mdw/blackh4wk <<EOFSQL
set echo on
spool gs.lst
Exec PROC_MANAGE_INDEXES(1,''W_AP_XACT_F'',''INVOICE_RECEIPT_DT_WID'',''W_AP_XACT_F_F23'',''BITMAP'',''Partitioned'');
spool off
exit
EOFSQL

