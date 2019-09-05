sqlplus mdw/blackh4wk <<EOFSQL
set echo on
spool gs.lst
exec proc_gather_stats('W_GL_ACCOUNT_D');
spool off
exit
EOFSQL

