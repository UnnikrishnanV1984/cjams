/*
Issue Description: Please remove the intake from the supervisor dashboard.
Category/Module: Error
Root cause: Old migrated intake request showed up on user's dashboard 
Fix provided: DB query remove intake request from the dashboard
Data/Code fix ticket#: CDM-42376
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data migration
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating record in routing
update routing
set activeflag = 0, updatedby = 'CDM-42376', updatedon = now()
where routingid = '0c02ad1d-b692-45be-8d05-4959741a2336' and activeflag = 1;