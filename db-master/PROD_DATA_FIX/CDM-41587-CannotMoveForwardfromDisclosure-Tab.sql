/*
Issue Description:Need to delete the rejected placement listed in the placement history page for Client ID: 200023549 (Justina Schneberger), Case# 3268522.  And need technical investigation as the rejected placement should not be considered in the closing checklist.
Category/Module: Error
Root cause: Rejected placement not considered in the closing checklist is an active CIDM
Fix provided: DB queries to remove dates/update exit type
Data/Code fix ticket#: CDM-41587
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-9452
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in placement
update placement
set activeflag = 0, updatedby = 'CDM-41587', updatedon = now()
where placementid = '5a458487-15f0-44ff-a8ef-83de5419c8d5' and activeflag = 1;

--Deactivating in plcementrevision
update placementrevision
set activeflag = 0, updatedby = 'CDM-41587', updatedon = now()
where placementid = '5a458487-15f0-44ff-a8ef-83de5419c8d5' and activeflag = 1;

--Deactivating in livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-41587', updatedon = now()
where placementid = '5a458487-15f0-44ff-a8ef-83de5419c8d5' and activeflag = 1;

--Deactivating in routing
update routing
set activeflag = 0, updatedby = 'CDM-41587', updatedon = now()
where objectid = '5a458487-15f0-44ff-a8ef-83de5419c8d5' and activeflag = 1;