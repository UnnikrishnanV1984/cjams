/*
Issue Description: Data fix to delete the POSC approval request from the 
supervisor approval dashboard since the case is already closed without approving/rejecting the POSC
Category/Module: Bug
Root cause: data fix to delete the POSC approval request from the 
supervisor approval dashboard since the case is already closed without approving/rejecting the POSC
Fix provided: Fix has been promoted to change the description to Father
Data/Code fix ticket#: CJAMS-59037
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/


update routing 
set activeflag = 0, updatedby = 'CJAMS-59037', updatedon = now() 
where routingid = 'ba40a980-3dee-42a3-bb56-40e9de411e02' 
and eventcode = 'SENSCP' and activeflag = 1;
