/*
 Issue Description: CDM-36552 Delete purchase authorization
 Category/ Module  : Purchase Authorization
 Root cause: User wants to remove the purchase authorization ID 2961033 as the same is not approved. Please delete Purchase Authorization ID# 2961033 
 fix: Datafix has been added to delete the record.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date:
 */

-- Backup
select * from tb_service_purchase_authorization where authorization_id = 2961033;

--Update
update
    tb_service_purchase_authorization
set
    delete_sw = 'Y',
    update_ts = now(),
    update_user_id = 'CDM-36552'
where
    authorization_id in ('2961033');