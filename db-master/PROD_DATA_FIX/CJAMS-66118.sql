/*
Issue Description:CJAMS-66118-CPS Intake showing pending after screened out
Root cause: Routing record in db is inactive so making the routing record active hence the case status is updated as closed from person search
Fix provided: Data fix has been done to make the routing record active
Regression Impacts: N/A
Is Code fix Required?: No, Issue is not replicable in staging environment
Code fix ticket#: N/A
Reason why no related code fix: 
*/




update routing set activeflag=1,updatedby='CJAMS-66118',updatedon=now()
where routingid = '3020af31-995e-490d-aa59-2bc094d95287' and routingstatustypeid = '8';