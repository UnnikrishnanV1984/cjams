/*
Issue: CJAMS-65171
Category/Module: Placement 
Root cause: User is unable to enddate the placement due to the row lock issue in the provider. This was blocking the placement approval flow.
            This happens when there is some transaction failure during the user request and we have come across this like 3 times in last three years
Fix provided:  Data fix has been done to remove the row lock
Data/Code fix ticket#: CJAMS-65171
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: No
*/

--Updating prov.tb_provider
update prov.tb_provider 
set row_lock = null, update_user_id = 'CJAMS-65171', update_ts = now()
where provider_id = 6274744;