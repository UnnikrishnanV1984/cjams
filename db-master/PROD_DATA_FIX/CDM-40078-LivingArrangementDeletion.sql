/*
Issue Description: Please delete the placement dated 11/19/21 - 1/11/22
Category/ Module : Error
Root cause: Duplicate entry in placement needed to be deactivated.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40078
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating placement table
update placement 
set 
	activeflag = 0,
	updatedby = 'CDM-40078',
	updatedon = now()
where placementid = '9b0a400d-b78b-4645-af3a-c7ec9022e9be' and activeflag = 1;

--Updating placementrevision table
update placementrevision
set
	activeflag = 0,
	updatedby = 'CDM-40078',
	updatedon = now()
where placementid = '9b0a400d-b78b-4645-af3a-c7ec9022e9be' and activeflag = 1;

--Nothing in livingarrangement

--Updating routing table
update routing 
set 
	activeflag = 0,
	updatedby = 'CDM-40078',
	updatedon = now()
where objectid = '9b0a400d-b78b-4645-af3a-c7ec9022e9be' and activeflag = 1;