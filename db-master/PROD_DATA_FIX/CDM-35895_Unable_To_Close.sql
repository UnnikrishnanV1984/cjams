/*
 Issue Description: CDM-35895
 Category/ Module  : Purchase Authorisation
 Root cause: User request to User wants to remove the purchase authorization ID 599177 as the same is not approved. Please delete Purchase Authorization ID# 599177 
 fix: Datafix has been added to delete the record.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
update
    tb_service_purchase_authorization
set
    delete_sw = 'Y',
    update_ts = now(),
    update_user_id = 'CDM-35895'
where
    authorization_id in ('599177');