/*
Issue Description: Please remove the rejected provider placement as highlighted below
Category/Module: Support
Root cause: Users cannot remove placements from closed cases
Fix provided: DB queries to deactivate placements causing issues with provider closure
Data/Code fix ticket#: CDM-43418
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating placement
update placement
set activeflag = 0, updatedby = 'CDM-43418', updatedon = now()
where placementid = '77e2949e-6176-4c7a-a3d9-30e0187a4a20' and activeflag = 1;

--Updating placementrevision
update placementrevision
set activeflag = 0, updatedby = 'CDM-43418', updatedon = now()
where placementid = '77e2949e-6176-4c7a-a3d9-30e0187a4a20' and activeflag = 1;

--Updating livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-43418', updatedon = now()
where livingid = '773912d2-e6e9-4ea5-bd9a-d0814c0858ed' and activeflag = 1;

--Updating routing
update routing
set activeflag = 0, updatedby = 'CDM-43418', updatedon = now()
where objectid = '77e2949e-6176-4c7a-a3d9-30e0187a4a20' and activeflag = 1;