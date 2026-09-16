
/*
Issue Description:remove the YTP review request from the supervisor approval inbox
Category/Module: Support
Root cause: due to data glitch casused to YTP request to  deletd .
Fix provided: DB query to change the routingstatustypeid value to approved in routing table
Data/Code fix ticket#: CJAMS-58884
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/
update routing
set activeflag = 0,updatedby = 'CJAMS-58884', updatedon = NOW()
where routingid = 'ef46fe23-5e21-47be-9360-9d0876574ee5' and activeflag = 1;
