/*
Issue Description: Please remove the highlighted living arrangement for Client ID: 200856959
Category/ Module: Error
Root cause: Placement was duplicate and needed deactivation
Fix provided: DB query to deactivate the duplicate placement.
Code/Data fix ticket#: CDM-40568
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-40568
Reason why no related code fix: DB issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating records in placement
update placement 
set activeflag = 0, updatedby = 'CDM-40568', updatedon = now()
where placementid = 'dbd4d44d-b216-4bf0-b9ad-627b92f0cafe' and activeflag = 1;

--Deactivating records in placementrevision
update placementrevision 
set activeflag = 0, updatedby = 'CDM-40568', updatedon = now()
where placementid = 'dbd4d44d-b216-4bf0-b9ad-627b92f0cafe' and activeflag = 1;

--Deactivating records in livingarrangement
update livingarrangement 
set activeflag = 0, updatedby = 'CDM-40568', updatedon = now()
where placementid = 'dbd4d44d-b216-4bf0-b9ad-627b92f0cafe' and activeflag = 1;

--Deactivating records in routing
update routing 
set activeflag = 0, updatedby = 'CDM-40568', updatedon = now()
where objectid = 'dbd4d44d-b216-4bf0-b9ad-627b92f0cafe' and activeflag = 1;