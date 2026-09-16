/*
Issue Description: Need to remove the rejected provider placement record as highlighted below
Category/Module: Error
Root cause: Rejected placement needed to be removed so user can create a new one
Fix provided: DB queries to deactivate the rejected placement
Data/Code fix ticket#: CDM-41275
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating placement
update placement 
set activeflag = 0, updatedby = 'CDM-41275', updatedon = now()
where placementid = 'd54682a7-f51d-41a9-a399-21648e394b61' and activeflag = 1;

--Updating placementrevision
update placementrevision 
set activeflag = 0, updatedby = 'CDM-41275', updatedon = now()
where placementid = 'd54682a7-f51d-41a9-a399-21648e394b61' and activeflag = 1;

--Updating livingarrangement
update livingarrangement 
set activeflag = 0, updatedby = 'CDM-41275', updatedon = now()
where placementid = 'd54682a7-f51d-41a9-a399-21648e394b61' and activeflag = 1;

--Updating routing
update routing 
set activeflag = 0, updatedby = 'CDM-41275', updatedon = now()
where routingid in ('1460920d-4235-40ec-a05e-700d0050c784', 'e91e6b6c-545f-4b0a-a9d1-4f464fc662b0') and activeflag = 1;