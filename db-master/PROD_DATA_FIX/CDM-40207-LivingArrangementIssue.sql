/*
Issue Description: Please delete the highlighted living arrangement for Client ID: 200660971
Category/ Module : Error
Root cause: The youth has a duplicate placement entered (Living Arrangement)
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40207
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating placement record
update placement
set activeflag = 0, updatedby = 'CDM-40207', updatedon = now()
where placementid = '52ed90a9-7246-42e6-917f-9067e0828170' and activeflag = 1;

--Deactivating placementrevision record
update placementrevision
set activeflag = 0, updatedby = 'CDM-40207', updatedon = now()
where placementid = '52ed90a9-7246-42e6-917f-9067e0828170' and activeflag = 1;

--Deactivating livingarrangement record
update livingarrangement
set activeflag = 0, updatedby = 'CDM-40207', updatedon = now()
where placementid = '52ed90a9-7246-42e6-917f-9067e0828170' and activeflag = 1;

--Deactivating routing record
update routing
set activeflag = 0, updatedby = 'CDM-40207', updatedon = now()
where objectid = '52ed90a9-7246-42e6-917f-9067e0828170' and activeflag = 1;