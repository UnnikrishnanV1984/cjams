
/*
Issue Description: Need data fix to remove duplicate records in guardianship table to allow user to complete the gap case.
Category/Module: Prod Data Fix to remove duplicate records in guardianship table
Root cause: Duplicate records in guardianship table due to which user is not able to complete the gap case.
Fix provided: Data fix has been done to set active flag 0 to duplicate records in guardianship table
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/delete:
select activeflag , permanencyplanid , * from guardianship g where permanencyplanid  ='9df0f97d-b9da-4ded-94b4-aa739f5f8909';

*/

update guardianship 
set activeflag = 0, updatedby = 'CJAMS-65109', updatedon = now()
where gapid in  ('a258493a-1d81-4c85-82a0-89fcff8fc742','1db7acda-681c-4709-a6cd-4130026f7c86','9148ddd6-7eab-4c7a-8941-840c0e425778','38b33313-73ae-4ceb-9897-2a78ef6f8f62','2cff7417-ef32-4877-afb2-abf6f45615b6') and activeflag =1;