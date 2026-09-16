-- CDM-18629 -  CJAMS - MDM person registration issues
-------------------------------------------------------------------------------------------------------
-- To update MDM Reference Value Codes in tb_picklist_values table
------------------------------------------------------------------------------------------------------- 

-- Blue
select picklist_value_cd, value_tx, mdmcode, update_ts, update_user_id
	from cjams.tb_picklist_values  
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1218' ; 

update cjams.tb_picklist_values
set mdmcode = 'E',
	update_ts = now(),
	update_user_id = 'CDM-18629'
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1218' ; 


-- Brown
select picklist_value_cd, value_tx, mdmcode, update_ts, update_user_id
	from cjams.tb_picklist_values  
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1219' ; 

update cjams.tb_picklist_values
set mdmcode = 'N',
	update_ts = now(),
	update_user_id = 'CDM-18629'
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1219' ;
	
-- Gray
select picklist_value_cd, value_tx, mdmcode, update_ts, update_user_id
	from cjams.tb_picklist_values  
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1220' ; 

update cjams.tb_picklist_values
set mdmcode = 'G',
	update_ts = now(),
	update_user_id = 'CDM-18629'
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1220' ;	
	
-- Green
select picklist_value_cd, value_tx, mdmcode, update_ts, update_user_id
	from cjams.tb_picklist_values  
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1221' ; 

update cjams.tb_picklist_values
set mdmcode = 'R',
	update_ts = now(),
	update_user_id = 'CDM-18629'
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1221' ;
	
-- Hazel
select picklist_value_cd, value_tx, mdmcode, update_ts, update_user_id
	from cjams.tb_picklist_values  
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1222' ; 

update cjams.tb_picklist_values
set mdmcode = 'H',
	update_ts = now(),
	update_user_id = 'CDM-18629'
where picklist_type_id = 79
	and trim(picklist_value_cd) = '1222' ;
	
