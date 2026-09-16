
/*
Issue: Permanency Plan Review Approval 
Category/Module: Routing
Root cause: Even when the permanency plan is approved, it is still displaying as pending in the Approval Inbox.
Fix provided: Data fix has been provided to inactivate the routing records which are in pending approval status.
Data/Code fix ticket#: CJAMS-65741
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Inactivating the routing records which are in pending approval status was done in the database.
*/
update routing
set activeflag =0, updatedby = 'CJAMS-65741', updatedon = now() 
where routingid = '5c7ebbfa-f4f6-4c48-a737-66de77e162d9';