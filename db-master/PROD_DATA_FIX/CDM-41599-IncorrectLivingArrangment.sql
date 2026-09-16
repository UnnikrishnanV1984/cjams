/*
Issue Description: Please remove the highlighted rejected Living Arrangement record as requested.
Category/Module: Error
Root cause: User entered the incorrect placement type
Fix provided: DB queries to deactivate the rejected living arrangement
Data/Code fix ticket#: CDM-41599
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-41599
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in placement
update placement
set activeflag = 0, updatedby = 'CDM-41599', updatedon = now()
where placementid = '7564fa0b-377e-4630-aea0-3f0f727276fe' and activeflag = 1;

--Deactivating in placementrevision
update placementrevision
set activeflag = 0, updatedby = 'CDM-41599', updatedon = now()
where placementid = '7564fa0b-377e-4630-aea0-3f0f727276fe' and activeflag = 1;

--Deactivating in livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-41599', updatedon = now()
where placementid = '7564fa0b-377e-4630-aea0-3f0f727276fe' and activeflag = 1;

--Deactivating in routing
update routing
set activeflag = 0, updatedby = 'CDM-41599', updatedon = now() 
where routingid = '2d116919-62af-416c-a2c9-2cd609495fbc' and activeflag = 1;