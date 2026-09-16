/*
Issue Description: 3193952:The service log was completed and then returned. It was redone rather then fixing the request and having it approved. This one could not be denied due to the duplicate request. Please either deny or delete this request.
Root cause:User requeted change status in childremoval.due to As per system design, the service log can not be ended when there is a review/returned Purchase Authorization in the open service log, the edit button will not visible until the purchase authorization get approved/denied.
Fix provided: update into routing,intakedastatus,intakedastaging,intakesnapshot table
Data/Code fix ticket#: CJAMS-62940
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User Error.
*/

update routing 
set routingstatustypeid ='62',remarks ='Denied',updatedby ='CJAMS-62940',updatedon =now()
where objectid IN ('3647309', '3647312')and activeflag =1;

update tb_service_purchase_authorization
set sprvsr_approval_status_cd = '3281', -- Denied
sprvsr_approval_dt = now(),
update_ts = now(),
update_user_id = 'CJAMS-62940'
where authorization_id in (3647309, 3647312)
and delete_sw = 'N';

