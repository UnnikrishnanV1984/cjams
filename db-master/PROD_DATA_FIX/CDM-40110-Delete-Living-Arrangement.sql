/*
Issue Description: Please remove the highlighted Living Arrangement record from Client ID: 4415999
Category/ Module : Error
Root cause: One Placement entry was entered twice, so duplicate needed to be deactivated.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40110
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
	updatedby = 'CDM-40110',
	updatedon = now()
where placementid = '9b857060-d3a2-4995-a5bb-728f629f59ec' and activeflag = 1;

--Updating placementrevision table
update placementrevision
set 
	activeflag = 0,
	updatedby = 'CDM-40110',
	updatedon = now()
where placementid = '9b857060-d3a2-4995-a5bb-728f629f59ec' and activeflag = 1;

--Updating livingarrangement table
update livingarrangement
set 
	activeflag = 0,
	updatedby = 'CDM-40110',
	updatedon = now()
where placementid = '9b857060-d3a2-4995-a5bb-728f629f59ec' and activeflag = 1;

--Updating routing table
update routing
set 
	activeflag = 0,
	updatedby = 'CDM-40110',
	updatedon = now()
where objectid = '9b857060-d3a2-4995-a5bb-728f629f59ec' and activeflag = 1;