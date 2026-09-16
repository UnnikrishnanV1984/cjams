/*
   Issue Description: CDM-44066
   Category/ Module :Purchase authorisation
   Root cause:

*/


UPDATE cjams.tb_service_purchase_authorization
SET funding_approval_dt= null, 
funding_approval_status_cd=null,
sprvsr_approval_status_cd = null, 
sprvsr_approval_dt = null,
ads_approval_status_cd = null, 
ads_approval_dt = null,
update_user_id='CDM-44066',
update_ts=now()
WHERE authorization_id=3702653 and delete_sw = 'N';


update routing 
set tosecurityusersid='12d0df4a-9b22-4f4d-a654-f8ecbbb5f85f', updatedby ='CDM-44066', updatedon = now()
where routingid = 'c3fb397e-9cfe-4530-a2a4-1609417aa007' and activeflag =1;
