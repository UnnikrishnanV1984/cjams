
/*
Issue: Supervisor no longer with agency  Ahmun R. Williams
Category/Module: Routing
Root cause:  The supervisor is no longer with the agency- Ahmun R. Williams. But the case plans are displaying in pending approval ta under his screen but there is no pending case plans
Fix provided: Data fix has been provided to inactivate the routing records which are in pending approval status.
Data/Code fix ticket#: CJAMS-66015
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The supervisor is no longer with the agency and there are no pending case plans under his screen. So, inactivating the routing records which are in pending approval status was done in the database.
*/
update routing set activeflag =0, updatedby = 'CJAMS-66015', updatedon = now()
where routingid in ('a4384b44-d701-491c-86a9-11cfc146a0eb','44f94163-e5da-48c2-bd3f-bd04dc459c9e') and activeflag = 1;