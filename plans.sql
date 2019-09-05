SELECT  p.plan_table_output
FROM    v$session s
,       table(dbms_xplan.display_cursor(s.sql_id, s.sql_child_number)) p
where   s.sid = &1
/
