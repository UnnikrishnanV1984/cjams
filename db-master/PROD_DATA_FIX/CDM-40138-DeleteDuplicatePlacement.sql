/*
Issue Description: Please remove/delete the Living Arrangement record as highlighted from Client ID: 4019290
Category/ Module : Error
Root cause: Duplicate Living Arrangement entry needed to be deactivated.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40138
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
	updatedby = 'CDM-40138',
	updatedon = now()
where placementid = 'd59d4ebe-fb97-4053-a655-d4f39d788621' and activeflag = 1;

--Updating placementrevision table
update placementrevision
set 
	activeflag = 0,
	updatedby = 'CDM-40138',
	updatedon = now()
where placementid = 'd59d4ebe-fb97-4053-a655-d4f39d788621' and activeflag = 1;

--Updating livingarrangement table
update livingarrangement
set 
	activeflag = 0,
	updatedby = 'CDM-40138',
	updatedon = now()
where placementid = 'd59d4ebe-fb97-4053-a655-d4f39d788621' and activeflag = 1;

--Updating routing table
update routing
set 
	activeflag = 0,
	updatedby = 'CDM-40138',
	updatedon = now()
where objectid = 'd59d4ebe-fb97-4053-a655-d4f39d788621' and activeflag = 1;