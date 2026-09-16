/*
-- Issue Description: 3255434:Worker entered incorrect client program name and sub program and there is no way to edit this section. 
                      Worker did not enter service end date which prevents new service being able to be entered to enter a correct entry. 
                      To be able to proceed, I am requesting Vendor Service -Provider ID 5008901 for Furniture (Paid) for Client 1722133 on 5/2/24 be deleted. 
-- Root cause: Change requested by user.
-- Fix Provided: Updated the tb_service_log table and tb_service_purchase_authorization table to soft delete.
*/

update tb_service_purchase_authorization
set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-38794'
where authorization_id = 3135909;

update tb_service_log
set delete_sw  = 'Y', update_ts = now(), update_user_id = 'CDM-38794'
where service_log_id = 3147621;

update routing
set activeflag = 0, updatedon = now(), updatedby = 'CDM-38794'
where objectid = '3135909'
and eventcode in ( 'PCAUTHR', 'PCAUTH' )
and activeflag = 1;

