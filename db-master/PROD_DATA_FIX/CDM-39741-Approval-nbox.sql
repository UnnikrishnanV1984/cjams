/*
Issue Description: A caseworker sent me two case connect review request in error to my approval inbox. I am inquiring about how to remove the case connect review request from my "case pending approval" tab in my approval inbox. The case numbers are 241022394886, 241022070571.
Category/ Module : Bug
Root cause: No option to reject or delete the case connect review request.
Need to do a Data fix as of now and need to work on a solution later to resolved this issue.
Fix provided: This only completes the first part of this ticket: Datafix
Code fix ticket#: CDM-39741
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
	updatedby = 'CDM-39741',
	updatedon = now()
where routingid in ('6097dc7a-9e8c-447b-93dd-fd01c57349d7', '471dd792-9a8b-4318-a9c7-85b1a06eeb49') and activeflag = 1;