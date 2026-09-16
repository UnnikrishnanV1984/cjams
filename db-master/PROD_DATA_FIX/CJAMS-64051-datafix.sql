/*
Issue Description: CJAMS-64051 Closing Checklist will not save
Category/Module: Out-of-home
Root cause: User requested to update the supervisor name for the latest routing record
Fix provided: Data fix has been promoted to update the supervisor name.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: The issue is specific to data and is not a recurring one or a logical issue.
*/

UPDATE routing 
SET tosecurityusersid='b0fbf926-91a3-4a91-a6a4-62e458683797', updatedon = NOW(), updatedby = 'CJAMS-64051'
WHERE routingid='40d52585-a902-4337-8d50-6070ca01183c';