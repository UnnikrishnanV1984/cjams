/*
Issue Description: Please remove the rejected placement as highlighted below.
Category/Module: Error
Root cause: Rejected placement needed to be removed so user can create a new one
Fix provided: DB queries to deactivate the rejected placement
Data/Code fix ticket#: CDM-41274
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating placement
update placement
set activeflag = 0, updatedby = 'CDM-41274', updatedon = now()
where placementid = '907f3ce1-e7e4-40f9-bf5e-2406bc40a1b2' and activeflag = 1;

--Updating placementrevision
update placementrevision
set activeflag = 0, updatedby = 'CDM-41274', updatedon = now()
where placementid = '907f3ce1-e7e4-40f9-bf5e-2406bc40a1b2' and activeflag = 1;

--Updating livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-41274', updatedon = now()
where placementid = '907f3ce1-e7e4-40f9-bf5e-2406bc40a1b2' and activeflag = 1;

--Updating routing
update routing
set activeflag = 0, updatedby = 'CDM-41274', updatedon = now()
where routingid = 'b139c932-823d-4b6b-a87f-52baba1334f3' and activeflag = 1;