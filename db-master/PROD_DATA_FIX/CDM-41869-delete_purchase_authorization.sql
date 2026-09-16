-- CDM-41869- delete purchase authorization
/*
-- Issue Description: 
   User request to delete purchase authorization
   
Client ID: 3658926 (KARMA WILLIAMS)
Auth ID: 3666328
Provider ID: 5096938 (Rockville Pediatric Dental LLC)
Service: Dental (Paid)

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Fix Provided: Datafix has been provided to delete the requested Purchase Authorization
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select * from tb_service_purchase_authorization where authorization_id = 3666328;
*/

update
    tb_service_purchase_authorization
set
    delete_sw = 'Y',
    update_ts = now(),
    update_user_id = 'CDM-41869'
where 
    authorization_id in ('3666328')
   	and delete_sw = 'N';	