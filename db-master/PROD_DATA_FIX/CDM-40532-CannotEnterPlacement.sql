/*
Issue Description: Please remove the rejected provider placement
Category/ Module: Bug
Root cause: User cannot enter current living arrangement/placement because of the rejected provider placement.
Fix provided: DB query to deactivate the rejected placement.
Code/Data fix ticket#: CDM-40532
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-40532
Reason why no related code fix: DB issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating record in placement
update placement
set activeflag = 0, updatedby = 'CDM-40532', updatedon = now()
where placementid = 'd868b529-d120-41ef-8eba-e234140e946d' and activeflag = 1;

--Deactivating record in placementrevision
update placementrevision 
set activeflag = 0, updatedby = 'CDM-40532', updatedon = now()
where placementid = 'd868b529-d120-41ef-8eba-e234140e946d' and activeflag = 1;

--Deactivating record in livingarrangement
update livingarrangement 
set activeflag = 0, updatedby = 'CDM-40532', updatedon = now()
where placementid = 'd868b529-d120-41ef-8eba-e234140e946d' and activeflag = 1;

--Deactivating record in routing
update routing 
set activeflag = 0, updatedby = 'CDM-40532', updatedon = now()
where objectid = 'd868b529-d120-41ef-8eba-e234140e946d' and activeflag = 1;