/*
Issue Description: Please remove the rejected provider placement for Client ID: 201012005, Provider ID: 5075210
Category/ Module : Bug
Root cause: Rejected entry under placement was preventing user from adding new placement for the client.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40037
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating placement
update placement
set 
	activeflag = 0,
	updatedby = 'CDM-40037',
	updatedon = now()
where placementid = 'a386af7c-e78c-4a19-87a9-08ca5c488260' and activeflag = 1;

--Updating placementrevision
update placementrevision
set 
	activeflag = 0,
	updatedby = 'CDM-40037',
	updatedon = now()
where placementid = 'a386af7c-e78c-4a19-87a9-08ca5c488260' and activeflag = 1;

--Updating livingarrangement
update livingarrangement
set 
	activeflag = 0,
	updatedby = 'CDM-40037',
	updatedon = now()
where livingid = 'bdbfa047-504f-49b4-ad1a-aed782f63d16' and activeflag = 1;

--Updating routing
update routing
set 
	activeflag = 0,
	updatedby = 'CDM-40037',
	updatedon = now()
where objectid = 'a386af7c-e78c-4a19-87a9-08ca5c488260' and activeflag = 1;