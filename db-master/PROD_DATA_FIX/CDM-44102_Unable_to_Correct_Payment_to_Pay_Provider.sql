/*
 Issue Description: CDM-44102 Delete purchase authorization
 Category/ Module  : Purchase Authorization
 Root cause: User wants to remove the purchase authorization ID 3703039 as the user was not able to process this payment. Once it is denied
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date:
 */

/*
select funding_approval_status_cd,delete_sw,* from tb_service_purchase_authorization where authorization_id = '3703039';
*/

update tb_service_purchase_authorization
set delete_sw = 'N', update_ts = now(), update_user_id = 'CDM-44102'
where authorization_id = '3703039';

update routing 
set routingstatustypeid = 62,
	remarks = 'Denied',
	updatedby = 'CDM-44102',
	updatedon = now()
where objectid ='3703039'
and activeflag =1;