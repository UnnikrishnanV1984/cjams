/*
Issue Description:CJAMS-64936-Supervisor Decision is not reflecting as finalized
Root cause: Routing record in db is inactive so making the routing record active hence the case status is updated as closed from person search
Fix provided: Data fix has been done to make the routing record active
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/




update routing set activeflag=1,updatedby='CJAMS-64936',updatedon=now()
where routingid = '4e2ab739-bcf0-422e-94f7-3a9c1fce0e45' and routingstatustypeid = '8';