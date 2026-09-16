/*
Issue Description: Please do a data fix to change the service plan start date and end date  to  4/17/2024 and 6/16/2024.
Category/ Module : Bug
Root cause: Service plan start date and end date for this instance need to be 4/17/2024 and 6/16/2024 to reflect 0-60 days.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39888
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating serviceplan
update serviceplan
set
	targetenddate = '2024-06-16 00:00:00',
	effectivedate = '2024-04-17 00:00:00',
	updatedby = 'CDM-39888',
	updatedon = now()
where serviceplanid = 'a3fc7bd3-3d1f-4f1c-9d84-613b54b147cd' and activeflag = 1;