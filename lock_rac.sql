set linesize 150
set pages 150
rem
ttitle 'Locked and Blocking Sessions'
col inst_id format 9 heading 'WAIT|INST|ID'
col sid format 9999 heading 'WAIT|SID'
col type format a4 heading 'TYPE'
col lmode format b9999 heading 'LMODE'
col request format b9999 heading 'REQUEST'
col ctime format 99999 heading 'SECONDS|HELD OR|WAITING'
col block format b9999 heading 'BLOCK'
col h_inst_id format 9 heading 'HOLD|INST|ID'
col h_sid format 9999 heading 'HOLD|SID'
col h_type format a4 heading 'TYPE'
col h_lmode format b9999 heading 'LMODE'
col h_request format b9999 heading 'REQUEST'
col h_ctime format 99999 heading 'SECONDS|HELD OR|WAITING'
col h_block format b9999 heading 'BLOCK'
col id1 format 999999999 heading 'ID1'
col id2 format 999999999 heading 'ID2'
rem
select w.inst_id,w.sid, w.type, w.block, w.ctime, w.lmode, w.request,
       h.inst_id, h.sid h_sid, h.type h_type, h.block h_block,
       h.ctime h_ctime, h.lmode h_lmode, h.request h_request,
       w.id1, w.id2
  from gv$lock h,
       gv$lock w
 where w.id1 = h.id1
   and w.id2 = h.id2
   and w.type = h.type
   and w.request > 0
   and h.block > 0
   order by w.id1, w.id2, w.block desc, w.ctime desc;
rem
set linesize 150
