-- CDM-34538 - Placement
/*
-- Issue Description:
-- Category/ Module: Placement
-- Fix Provided: Datafix to remove the duplicate living arrangement records
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE livingarrangement 
SET activeflag = 0, updatedby = 'CDM-34538', updatedon = now() 
WHERE livingid in ('c747b92d-ebfd-4c6f-8817-5277057ba612', '59bef8c2-001a-42e7-b5f4-16ffb64ecb5b',
'25919650-400d-4e7a-8a4b-03a22dbe597e','7a465a12-46c4-4200-a9fd-0d851a78fde6');

UPDATE tb_provider_addresses 
SET adr_default_sw = 'N', update_ts = now(), update_user_id = 'CDM-34538'  
where address_id = 204803;


