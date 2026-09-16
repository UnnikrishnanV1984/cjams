/*
Issue Description: Please remove the highlighted living arrangement records
Category/Module: Bug
Root cause: Living arrangements needed to be removed
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40414
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating placement records
update placement 
set activeflag = 0, updatedby = 'CDM-40414', updatedon = now()
where placementid in ('66bcd50b-4d9d-48de-a90a-8271b52c543e', '80628776-7097-4e72-b301-1b2b7ad6ee85', '59a80c22-c03d-4c26-82f5-c242073f065e')
	and activeflag = 1;
	
--Deactivating placementrevision records
update placementrevision 
set activeflag = 0, updatedby = 'CDM-40414', updatedon = now()
where placementid in ('66bcd50b-4d9d-48de-a90a-8271b52c543e', '80628776-7097-4e72-b301-1b2b7ad6ee85', '59a80c22-c03d-4c26-82f5-c242073f065e')
	and activeflag = 1;
	
--Deactivating livingarrangement records
update livingarrangement 
set activeflag = 0, updatedby = 'CDM-40414', updatedon = now()
where placementid in ('66bcd50b-4d9d-48de-a90a-8271b52c543e', '80628776-7097-4e72-b301-1b2b7ad6ee85', '59a80c22-c03d-4c26-82f5-c242073f065e')
	and activeflag = 1;
	
--Deactivating routing records
update routing
set activeflag = 0, updatedby = 'CDM-40414', updatedon = now()
where objectid in ('66bcd50b-4d9d-48de-a90a-8271b52c543e', '80628776-7097-4e72-b301-1b2b7ad6ee85', '59a80c22-c03d-4c26-82f5-c242073f065e')
	and activeflag = 1;