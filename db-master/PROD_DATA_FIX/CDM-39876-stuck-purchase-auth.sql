/*
 Issue Description: CDM-39876Delete purchase authorization
 Category/ Module  : Purchase Authorization
 Case #: 3074460
 Root cause: User wants to remove the purchase authorization ID 3366907 as the same is not approved. Please delete Purchase Authorization ID# 3366907 
 fix: Datafix has been added to delete the record.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date:
 */



update tb_service_purchase_authorization
	set delete_sw = 'Y',
		update_ts = now(),
		update_user_id = 'CDM-39876'
	where authorization_id = 3366907;

	
		
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39876'
    where routingid = '24c301f6-3413-4b15-a5b2-bd027fd7b3b5'
		and objectid = '3366907'
    	and activeflag = 1;		