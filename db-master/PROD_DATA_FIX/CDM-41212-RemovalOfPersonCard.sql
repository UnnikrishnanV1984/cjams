/*
Issue Description: Please remove STEPHANIE D WILT (CJAMS PID-2295574) from this service case -221030017909 and this intake I221010304953
Category/Module: Error
Root cause: Person card of the same client was attached in the others tab by error
Fix provided: DB queries to deactivate the person entry
Data/Code fix ticket#: CDM-41212
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in actor
update actor
set activeflag = 0, updatedby ='CDM-41212', updatedon = now()
where actorid = 'c68c1468-dc5a-4b4b-9031-db8ae3e3a37c' and activeflag = 1;

--Deactivating in intakeservicerequestactor
update intakeservicerequestactor 
set activeflag = 0, updatedby ='CDM-41212', updatedon = now()
where intakeservicerequestactorid in ('989e316d-756b-43fb-ba86-70dbd8ebc8d6', '8e9917d0-f71b-4eed-afba-e9f3637ebd16') and activeflag = 1;

--Deactivating in actorrelationship
update actorrelationship
set activeflag = 0, updatedby ='CDM-41212', updatedon = now()
where intakeservicerequestactorid in ('989e316d-756b-43fb-ba86-70dbd8ebc8d6', '8e9917d0-f71b-4eed-afba-e9f3637ebd16') and activeflag = 1;

--Deactivating in personrole
update personrole
set activeflag = 0, updatedby ='CDM-41212', updatedon = now()
where personroleid = '149f7d30-2aec-4acc-92d5-19a2c155d300' and activeflag = 1;

--Nothing in personprogramarea