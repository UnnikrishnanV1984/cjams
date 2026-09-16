/*
   Issue Description: CDM-29748
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CDM-29748', updatedon = now()
where intakeservreqchildremovalid = 'c0f0cb61-0aad-4334-83d4-17b42f61c0eb';