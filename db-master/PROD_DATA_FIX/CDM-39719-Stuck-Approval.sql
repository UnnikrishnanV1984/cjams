/*
Issue Description: I am renewing a request I made back in April.In my approval box there is a request for A. Humphrey for an approval of permanency plan. The task is completed but the approval will not leave the approval box. I am requesting that you remove it. 
Category/ Module : Bug
Root cause: Please remove the below highlighted information from the pending approval dashboard of the worker.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-39719
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
	updatedby = 'CDM-39719',
	updatedon = now()
where routingid = 'f71d534e-7bfe-444d-99bb-01bb71816021' and activeflag = 1;