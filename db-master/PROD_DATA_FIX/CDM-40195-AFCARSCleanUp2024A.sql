/*
Issue Description: Please delete the highlighted living arrangement for Client ID; 200779690
Category/ Module : Error
Root cause: The Living arrangement for 8/10/2022 should be voided as it was entered pending a correction to the resource home.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40195
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating placement record
update placement
set activeflag = 0, updatedby = 'CDM-40195', updatedon = now()
where placementid = '3a147154-9d55-4f3e-a7a5-602b9be434a7' and activeflag = 1;

--Deactivating placementrevision record
update placementrevision
set activeflag = 0, updatedby = 'CDM-40195', updatedon = now()
where placementid = '3a147154-9d55-4f3e-a7a5-602b9be434a7' and activeflag = 1;

--Deactivating livingarrangement record
update livingarrangement
set activeflag = 0, updatedby = 'CDM-40195', updatedon = now()
where placementid = '3a147154-9d55-4f3e-a7a5-602b9be434a7' and activeflag = 1;

--Deactivating routing record
update routing
set activeflag = 0, updatedby = 'CDM-40195', updatedon = now()
where objectid = '3a147154-9d55-4f3e-a7a5-602b9be434a7' and activeflag = 1;