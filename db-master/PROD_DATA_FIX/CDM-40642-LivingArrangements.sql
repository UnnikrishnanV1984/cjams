
/*
Issue Description: Please remove the highlighted living arrangement records
Category/Module: Bug
Root cause: Duplicate Living arrangement needed to be removed
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40642
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating placement records

update placement 
set activeflag = 0, updatedby = 'CDM-40642', updatedon = now()
where placementid = '427ff8f8-5045-4a26-b805-9fb828405c7a'	and activeflag = 1;
	
--Deactivating placementrevision records

update placementrevision 
set activeflag = 0, updatedby = 'CDM-40642', updatedon = now()
where placementid = '427ff8f8-5045-4a26-b805-9fb828405c7a'	and activeflag = 1;
	
--Deactivating livingarrangement records


update livingarrangement 
set activeflag = 0, updatedby = 'CDM-40642', updatedon = now()
where placementid = '427ff8f8-5045-4a26-b805-9fb828405c7a'	and activeflag = 1;
	
--Deactivating routing records

update routing
set activeflag = 0, updatedby = 'CDM-40642', updatedon = now()
where objectid = '427ff8f8-5045-4a26-b805-9fb828405c7a'	and activeflag = 1;