/*
Issue: Permanency Plan Review Approval 
Category/Module: Routing
Root cause: Even when the permanency plan is approved, it is still displaying as pending in the Approval Inbox.
Fix provided: Data fix has been provided to inactivate the routing records which are in pending approval status.
Data/Code fix ticket#: CJAMS-68244
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Inactivating the routing records which are in pending approval status was done in the database.
*/

update routing set activeflag =0,
updatedby ='CJAMS-68244',updatedon =now()
where routingid ='cd7a2109-885b-4967-8c68-bde58f5985cd' and eventcode ='PPLR' and activeflag =1;