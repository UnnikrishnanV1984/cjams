-- CDM-44094 - Service Log lost from Director Approval to Funding Approval
/* Issue Description: Service Log is not visible even after the director approval for the payment, This service auth does not appear in funding approval for any of our users. 
The expectation is for it to appear in funding approval after anyone with director or delegated director approval approves a service authorization

-- Auth Id: 3712523

-- Category/ Module: Service Log 

-- Root cause: Service Log is not visible even after the director approval for the payment, This service auth does not appear in funding approval for any of our users. 
The expectation is for it to appear in funding approval after anyone with director or delegated director approval approves a service authorization, as ther was routing issue 
-- Fix Provided: Datafix has been provided to update the request to before approval.
-- Pull request# N/A

*/

UPDATE cjams.tb_service_purchase_authorization
SET funding_approval_dt= null, 
funding_approval_status_cd=null,
update_user_id='CDM-44094',
update_ts=now()
WHERE authorization_id=3712523;
