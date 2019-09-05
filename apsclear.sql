rem ********************************************************************
rem * Description       : clear APS definitions and settings.
rem * Usage             : start apsclear.sql
rem ********************************************************************

rem ********************************************************************
rem SPOOLING 
rem ********************************************************************
rem * To complete the APS spool off routine, the SQL*Plus varaible
rem * spool_value must be set to off (which is was in apsenv.sql) AND
rem * the internal APS spool column must be set to NULL.  If NULL is
rem * not set then if a user want to spool outside the control of
rem * apsenv.sql then can't because apshook.sql will keep setting 
rem * spool_value to "off."

rem set termout off
rem 
rem col val1 new_value userid noprint
rem select userenv('SESSIONID') val1
rem from   dual;
rem 
rem DECLARE
rem   uid    char(30);
rem   t1     char(3);
rem BEGIN
rem   If spooling has been turned off via sql*plus then honor this
rem   request by not having the APS turn it back on.
rem 
rem   if ('&SPOOL_VALUE' = 'off') -- return spool control to SQL*Plus
rem   then
rem     update aps_user_profile
rem     set    spool_fn  = '',
rem            spool_dir = ''
rem     where  userid=&userid;
rem   end if;
rem END;
rem /
rem set termout on

rem ********************************************************************
rem STANDARD ENVIRONMENT CLEAR
rem ********************************************************************
undef aps_prog
undef aps_title
undef now
undef 1
undef 2
undef 3
undef 4
undef 5
undef 6
undef 7
undef 8
undef 9
ttitle off
btitle off
clear col
clear bre

