/*
CJAMS-60793
Missing Placement Info
--	Issue Description: Missing Placement Info
please update: User requested to update the provider information for the placement for the Child from 05/02/2017 - 07/01/2017 to the provider (5038235 Ana Navarro)
-- Fix Provided: Datafix has been done to update the provider information for the placement for the Child from 05/02/2017 - 07/01/2017 to the provider (5038235 Ana Navarro)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE prov.tb_provider_addresses
SET adr_default_sw='Y', update_user_id='CJAMS-60793', update_ts=now() 
WHERE parent_key_id = '5038235'
and address_id=117538;
