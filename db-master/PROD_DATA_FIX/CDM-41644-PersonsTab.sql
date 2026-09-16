/*
Issue Description: SSA/Product Owner Approved to remove the Client ID: 1429301 (BRIDGETTE WHITE) from CPS AR# 241022910348.
Category/Module: Error
Root cause: The person was incorrectly added to the AR case
Fix provided: DB queries remove person from the CPS case
Data/Code fix ticket#: CDM-41644
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating person in actor
update actor 
set activeflag = 0, updatedby = 'CDM-41644', updatedon = now()
where actorid = 'f1aa3cbb-37a3-4ebd-9014-abee4d747a01' and activeflag = 1;

--Deactivating person in intakeservicerequestactor
update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-41644', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'3505a1c2-1117-4381-991a-6adf8312ba71',
'ac6c65b9-e6f5-40b9-b00d-d897722c45c0',
'7aae210b-b000-43b6-b533-bda0d0d3944b',
'da9a1726-5e1e-45b7-b683-d7ccc1e460f5');

--Deactivating person in actorrelationship
update actorrelationship 
set activeflag = 0, updatedby = 'CDM-41644', updatedon = now()
where activeflag = 1 and actorrelationshipid in (
'1c10b133-b9c7-4674-8263-08e58fdceac4',
'f0904eca-80df-467a-9cfd-62e13bb65913',
'4f11c018-da50-422b-b28f-cf656590a6fd',
'e6772e6e-e023-49c6-9adf-163a105e0bd0');

--Deactivating person in personrole
update personrole 
set activeflag = 0, updatedby = 'CDM-41644', updatedon = now()
where personroleid = 'd9577b09-1aa8-41cf-9f87-88dda11032ca' and activeflag = 1;

--Deactivating person in personprogramarea
update personprogramarea 
set activeflag = 0, updatedby = 'CDM-41644', updatedon = now()
where personprogramid = '29929230-72b5-44f9-b169-0d8f81777b39' and activeflag = 1;