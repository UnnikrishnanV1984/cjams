/*
Issue Description: Please remove the POSC review request from the supervisor pending approval dashboard.
Category/ Module : Bug
Root cause: Approved POSC request got stuck in approval inbox even after approavl.
Fix provided: Yes, write DB query
Code fix ticket#: CDM-40038
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
	updatedby = 'CDM-40038',
	updatedon = now()
where routingid = 'be7fc3c7-a162-4ba1-af26-6e10fd532ad8' and activeflag = 1;