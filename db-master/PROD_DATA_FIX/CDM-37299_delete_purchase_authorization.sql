/*
 Issue Description: CDM-37299 Delete purchase authorization
 Category/ Module  : Purchase Authorization
 Case #: 3074460
 Root cause: User wants to remove the purchase authorization ID 3023898 as the same is not approved. Please delete Purchase Authorization ID# 3023898 
 fix: Datafix has been added to delete the record.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date:
 */

select * from tb_service_purchase_authorization where authorization_id = 3023898;

update tb_service_purchase_authorization
	set delete_sw = 'Y',
		update_ts = now(),
		update_user_id = 'CDM-37299'
	where authorization_id = 3023898;

select routingid, eventcode, objectid, routingstatustypeid
	from routing 
	where routingid = '929e2d59-f260-4904-9ea9-35ab96903931' 
		and objectid = '3023898'
		and activeflag = 1;	
		
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37299'
    where routingid = '929e2d59-f260-4904-9ea9-35ab96903931'
		and objectid = '3023898'
    	and activeflag = 1;		