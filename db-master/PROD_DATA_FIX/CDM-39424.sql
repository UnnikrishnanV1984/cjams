/*
 * CDM-39424 - CJAMS ERRORS PREVENTING APPROVAL
 * Customer Email ID:elemon@maryland.gov
 * Focus Area:SDM
 * Getting error in SDM tab when opening the intake in production, not able to navigate to other tabs from SDM. 
 * replicated the issue in stg3 when the same child is added to the intake(CJAMS ID- 4307140) and selecting Provider involved maltreatment
 * 
 */

--select adr_default_sw, * from tb_provider_addresses where parent_key_id = '5078642' and address_id ='120661';		
UPDATE prov.tb_provider_addresses
SET adr_default_sw='Y', update_user_id='CDM-39424', update_ts=now() 
WHERE address_id=120661;
