rem ********************************************************************
rem * Filename		: apstitle.sql - Version 1.7
rem * Description	: Standard APS title header
rem * Usage		: start apstitle.sql
rem ********************************************************************

set termout off
break on today
col today new_value now
select to_char(sysdate, 'YYYY Mon DD HH:MIam') today 
from   dual;

set heading off
set feedback off
col val1 new_value db noprint
select value val1 
from   v$parameter 
where  name = 'instance_name';
set feedback on

clear breaks
set termout on
set heading on

ttitle -
    left 'Instance: &db'        right now              skip 0 -
    left '  Report: &aps_prog'  right 'Page ' sql.pno  skip 2 -
    center '&aps_title'                                skip 3



