/*
Issue Description: Please remove the APPLA approval request from the user dashboard.
Category/ Module : Bug
Root cause: Request was already approved, but got stuck in approval inbox.
Fix provided: Yes, write db query
Code fix ticket#: CDM-40112
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing table
update routing
set
	activeflag = 0,
	updatedby = 'CDM-40112',
	updatedon = now()
where routingid = '1831c72e-9fbe-43e9-bd3b-715bd939dc05' and activeflag = 1;