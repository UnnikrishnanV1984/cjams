-- CIDM-4135 - DRAFT Payment failure
/*
-- Issue Description: 
   DRAFT Payment batch failed 
   Provider Batch Checklist Stored Procedure failed due to the multiple duplicate Provider Category records.
   Provider ID: 6002122 (Katrina Jo Anderson) - Local Department Home

-- Category/ Module: CJAMS Finance DRAFT Payment Batch (Finance Batch Job) 
-- Root cause: Data issue (Multiple duplicate Provider Category records)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix for Provider ID: 6002122 (Katrina Jo Anderson) - Local Department Home
-- 3304	Vendor

select provider_picklist_id, provider_id, picklist_value_cd, delete_sw, update_ts, update_user_id 
	from prov.tb_provider_picklist
where provider_picklist_id = 50749295
	and provider_id = 6002122
	and picklist_type_id = 155
	and delete_sw = 'N' ;

update prov.tb_provider_picklist
set delete_sw = 'Y',
	update_user_id = 'CIDM-4135',
	update_ts = now()
where provider_picklist_id = 50749295
	and provider_id = 6002122
	and picklist_type_id = 155
	and delete_sw = 'N' ;
	
-- Datafix to update below 2 snapshot dependent jobs as Inactive 
-- 3 - snapshot_payment_1.sh
-- 4 - snapshot_payment_2.sh
-- CJAMS is not havig logic to capture the snapshot data
	
select batch_master_id, batch_nm, batch_detail_desc_tx, active_sw, batch_master_id 
	from tb_batch_master 
where batch_master_id in ( 3, 4 )
	and active_sw = 'Y' ;
	
update tb_batch_master 
set active_sw = 'N'	
where batch_master_id in ( 3, 4 )
	and active_sw = 'Y' ;

