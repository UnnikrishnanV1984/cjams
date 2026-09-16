--##############################################
-- POST MIGRATION SCRIPT FOR INTERFACES
-- 10/1/2019
--##############################################


--==FMIS REFERENCE TABLE DATA UPDATE

--set values to N27
UPDATE TB_PICKLIST_VALUES 
   SET CATEGORY_TX ='N27'
 WHERE PICKLIST_TYPE_ID = 1550 AND PICKLIST_VALUE_CD = '7748';

UPDATE TB_PICKLIST_VALUES 
   SET CATEGORY_TX ='N27'
 WHERE PICKLIST_TYPE_ID = 1550 AND PICKLIST_VALUE_CD = '7729';


--== SET TRIGGER TABLES FOR CARES/CSES TO NON ACTIVE STATUS SO CHESSIE TRIGGERS DO NOT GET TRIGGERED AFTER GO LIVE

UPDATE CARESOUTBOUNDTRIGGER 
   SET STATUSFLAG='W'
 WHERE STATUSFLAG='N' and activeflag = 1;

UPDATE CSESOUTBOUNDTRIGGER
   SET STATUSFLAG='W'
 WHERE STATUSFLAG='N' and activeflag = 1;
 


--SEQUENCES TO BE INITIALIZED TO MAX VALUE

SELECT setval('sq_tb_batch_log_id', COALESCE((select max(batch_log_id) from tb_batch_log), 1), true);

SELECT setval('sq_tb_batch_sp_log_id', COALESCE((select max(batch_sp_log_id) from tb_batch_sp_log), 1), true);

SELECT setVal('interfaceserrorlog_errorid_seq', COALESCE((select max(errorid) from interfaceserrorlog ), 1), true);

SELECT setVal('interfacesruntimeslog_runid_seq', COALESCE((select max(runid) from interfacesruntimeslog ), 1), true);

--SELECT setVal('sq_fmis_response', COALESCE((select max(fmis_response_id) from TB_FMIS_RESPONSE ), 1), true);

SELECT setVal('sq_afs_response', COALESCE((select max(afs_response_id) from tb_afs_response ), 1), true);

--== ADD NEW BATCH entries
--
-- SET FOR BATCH EXPUNGEMENT SETTINGS	
update tb_batch_sp_master 
set sp_nm='sp_expunge_insert', comments_tx=null where batch_sp_master_id = 54;

update tb_batch_sp_master 
set sp_nm='expungementbatch', comments_tx=null where batch_sp_master_id = 53;

