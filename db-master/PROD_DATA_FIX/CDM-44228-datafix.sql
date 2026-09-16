/*
Issue Description:data fix to update the Service Plan start date from 2/6/2025 to 1/6/2025
Category/ Module : Bug
Root cause: Data fix to update the Service Plan start date from 2/6/2025 to 1/6/2025
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-44228
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update serviceplan
set
	effectivedate = '2025-01-06 05:00:00',
	updatedby = 'CDM-44228',
	updatedon = now()
where serviceplanid = '111473fc-fc41-4f06-a3b6-4e0795211d44' and activeflag = 1;