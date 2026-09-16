-- FMIS Vendor Interface Batch Failure (Data Issue) - Production
-- Duplicate Provider Category records

select provider_id, picklist_type_id, picklist_value_cd, update_ts, update_user_id, delete_sw
	from tb_provider_picklist
where provider_id = 6000872
	and picklist_type_id = 155
	and provider_picklist_id = 50743982 ;
 

update tb_provider_picklist
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'DFX06012021'
where provider_id = 6000872
	and picklist_type_id = 155
	and provider_picklist_id = 50743982 ;