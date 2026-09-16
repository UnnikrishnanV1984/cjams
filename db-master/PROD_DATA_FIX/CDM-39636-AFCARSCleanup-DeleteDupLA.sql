/*
Issue Description: Data fix needed to removed the duplicate Living Arrangement mentioned below.
Living Arrangement with Address: 12507 Olivine Ct, Hagerstown, Maryland 21740.
Category/ Module : Bug
Root cause: One Provided Placement entry had a duplicate under the name Living Arrangement.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-39636
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
	updatedby = 'CDM-39636',
	updatedon = now()
where placementid = '23f9facd-f068-4f0a-b6ac-89a756876c8f' and activeflag = 1;

--Updating placementrevision table
update placementrevision
set 
	activeflag = 0,
	updatedby = 'CDM-39636',
	updatedon = now()
where placementid = '23f9facd-f068-4f0a-b6ac-89a756876c8f' and activeflag = 1;

--Updating livingarrangement table
update livingarrangement
set 
	activeflag = 0,
	updatedby = 'CDM-39636',
	updatedon = now()
where placementid = '23f9facd-f068-4f0a-b6ac-89a756876c8f' and activeflag = 1;

--Updating routing table
update routing
set 
	activeflag = 0,
	updatedby = 'CDM-39636',
	updatedon = now()
where objectid = '23f9facd-f068-4f0a-b6ac-89a756876c8f' and activeflag = 1;