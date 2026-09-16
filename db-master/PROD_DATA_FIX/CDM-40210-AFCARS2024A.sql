/*
Issue Description: Please remove the highlighted living arrangement for Client ID: 4311043
Category/ Module : Error
Root cause: This living arrangement needs to be voided or deleted as it overlaps with a provider placement.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40210
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating placement record
update placement
set activeflag = 0, updatedby = 'CDM-40210', updatedon = now()
where placementid = '3e3e3ed2-5fe5-4899-88c4-33d036bb9522' and activeflag = 1;

--Deactivating placementrevision record
update placementrevision
set activeflag = 0, updatedby = 'CDM-40210', updatedon = now()
where placementid = '3e3e3ed2-5fe5-4899-88c4-33d036bb9522' and activeflag = 1;

--Deactivating livingarrangement record
update livingarrangement
set activeflag = 0, updatedby = 'CDM-40210', updatedon = now()
where placementid = '3e3e3ed2-5fe5-4899-88c4-33d036bb9522' and activeflag = 1;

--Deactivating routing record
update routing
set activeflag = 0, updatedby = 'CDM-40210', updatedon = now()
where objectid = '3e3e3ed2-5fe5-4899-88c4-33d036bb9522' and activeflag = 1;