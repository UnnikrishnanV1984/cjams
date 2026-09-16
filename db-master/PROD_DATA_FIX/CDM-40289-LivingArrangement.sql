/*
Issue Description: Please remove the highlighted living arrangement for Client ID: 200006343
Category/Module: Bug
Root cause: Need living arrangement that was rejected to be deleted.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40289
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating record in placement
update placement
set activeflag = 0, updatedby = 'CDM-40289', updatedon = now()
where placementid = '1dfcc461-ef31-4ba9-a5b5-0a02ca89c482' and activeflag = 1;

--Deactivating record in placementrevision
update placementrevision 
set activeflag = 0, updatedby = 'CDM-40289', updatedon = now()
where placementid = '1dfcc461-ef31-4ba9-a5b5-0a02ca89c482' and activeflag = 1;

--Deactivating record in livingarrangement
update livingarrangement 
set activeflag = 0, updatedby = 'CDM-40289', updatedon = now()
where placementid = '1dfcc461-ef31-4ba9-a5b5-0a02ca89c482' and activeflag = 1;

--Deactivating record in routing
update routing 
set activeflag = 0, updatedby = 'CDM-40289', updatedon = now()
where objectid = '1dfcc461-ef31-4ba9-a5b5-0a02ca89c482' and activeflag = 1;