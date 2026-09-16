/*
Issue Description: Please remove two highlighted Living Arrangements as requested.
Category/ Module : Bug
Root cause: The 2 living arrangements date 7/3/21-4/26/22 with no caregiver listed should be deleted.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39850
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
	updatedby = 'CDM-39850',
	updatedon = now()
where placementid in ('d40b2d0a-cdc7-43a6-9460-6737f5f6427c', 'f57f7677-45aa-4127-82c7-8907f8e304f5')
and activeflag = 1;

--Updating placementrevision table
update placementrevision
set 
	activeflag = 0,
	updatedby = 'CDM-39850',
	updatedon = now()
where placementid in ('d40b2d0a-cdc7-43a6-9460-6737f5f6427c', 'f57f7677-45aa-4127-82c7-8907f8e304f5')
and activeflag = 1;

--Nothing in livingarrangement table

--Updating routing table
update routing
set 
	activeflag = 0,
	updatedby = 'CDM-39850',
	updatedon = now()
where objectid in ('d40b2d0a-cdc7-43a6-9460-6737f5f6427c', 'f57f7677-45aa-4127-82c7-8907f8e304f5')
and activeflag = 1;