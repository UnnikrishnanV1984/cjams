-- CDM-44072 - Missing a pending payment
/* Issue Description: A payment to Diana Grove (5089595) is missing. This is a payment for $323.74 with authorization ID# 3707625. The funding was released by Ann Viol on January 23rd but this payment does not show up under payments pending approval

-- Auth Id: 3707625

-- Category/ Module: Service Log 

-- Root cause: A payment to Diana Grove (5089595) is missing. This is a payment for $323.74 with authorization ID# 3707625. 
The funding was released by Ann Viol on January 23rd but this payment does not show up under payments pending approval, as ther was routing issue 
-- Fix Provided: Datafix has been provided to update the request to before approval, so finance worker can resubmit the request.
-- Pull request# N/A

*/

UPDATE cjams.tb_service_purchase_authorization
SET funding_approval_dt= null, 
funding_approval_status_cd=null,
sprvsr_approval_status_cd = null, 
sprvsr_approval_dt = null,
ads_approval_status_cd = null, 
ads_approval_dt = null,
update_user_id='CDM-44072',
update_ts=now()
WHERE authorization_id=3707625;
