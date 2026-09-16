/*
 Issue Description: CDM-42832 Delete purchase authorization
 Category/ Module  : Purchase Authorization
 Root cause:A duplicate Purchase Authorization (3075308) has been entered by the worker and unable to submit to the Supervisor for denying it. User requested to delete the purchase Authorization.
 fix: Datafix has been added to delete the record.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date:
 */
/*
select * from tb_service_purchase_authorization where authorization_id = 3075308;
*/

update tb_service_purchase_authorization
	set delete_sw = 'Y',
		update_ts = now(),
		update_user_id = 'CDM-42832'
	where authorization_id = 3075308;
