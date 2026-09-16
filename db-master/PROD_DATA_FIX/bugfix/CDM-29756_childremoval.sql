/*
   Issue Description: CDM-29756
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CDM-29756', updatedon = now()
where intakeservreqchildremovalid = '248ccd7c-e78f-41c9-8d73-2590fd4b4c4a';