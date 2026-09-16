/*
   Issue Description: CDM-26154
   Category/ Module  : Close Purchase Authorization
   Root cause: Close Purchase Authorization
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--Updating this authorization as Denied
-- Update tb_service_purchase_authorization
update tb_service_purchase_authorization
set ads_approval_status_cd = '3281', -- Denied
 ads_approval_dt = now(),
 update_ts = now(), 
 update_user_id = 'CDM-26154'
where authorization_id = 1802052
and delete_sw = 'N';


-- routingstatustypeid = '62', remarks = 'Denied'  
update routing set routingstatustypeid = 62, remarks = 'Denied', updatedby = 'CDM-26154', updatedon = now() where routingid = '7fcaef54-3065-411a-b76d-379e69be6feb' and objectid = '1802052'
 and eventcode in ( 'PCAUTHR', 'PCAUTH')
and activeflag = 1;
