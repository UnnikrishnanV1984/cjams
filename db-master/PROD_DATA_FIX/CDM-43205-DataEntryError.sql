/*
Issue Description: Please remove the rejected placement as highlighted below 
Category/Module: Support
Root cause: Application does not allow entire placement records to be deleted
Fix provided: DB queries to deactivate rejected placement to prevent overlap
Data/Code fix ticket#: CDM-43205
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in placement
update placement
set activeflag = 0, updatedby = 'CDM-43205', updatedon = now()
where placementid = '2cc94107-658a-43f5-aedc-94673b0f8955' and activeflag = 1;

--Deactivating in placementrevision
update placementrevision
set activeflag = 0, updatedby = 'CDM-43205', updatedon = now()
where placementid = '2cc94107-658a-43f5-aedc-94673b0f8955' and activeflag = 1;

--Deactivating in livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-43205', updatedon = now()
where livingid = '89cc53bb-4c3b-43a1-92e1-0a7934aa7d11' and activeflag = 1;

--Deactivating in routing
update routing
set activeflag = 0, updatedby = 'CDM-43205', updatedon = now()
where routingid = '88c19941-c407-4a84-a008-99cfeede0079' and activeflag = 1;