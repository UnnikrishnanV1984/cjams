/*
Issue Description: Please remove below Adoption cases from user's Adoption dashboard (as specialist)
These are already approved by supervisor
200140264
200885402
Category/Module: Bug
Root cause: Clients were still visible in specialist dashboard despite approval
Fix provided: DB query to remove clients from dashboard
Data/Code fix ticket#: CDM-42027
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing
update routing
set activeflag = 0, updatedby = 'CDM-42027', updatedon = now()
where routingid in ('c2d1c163-3d8a-46a9-a365-3f0b0e5cfc82', '156c9f30-7b85-4bb9-9310-615c78fd3e48') and activeflag = 1;