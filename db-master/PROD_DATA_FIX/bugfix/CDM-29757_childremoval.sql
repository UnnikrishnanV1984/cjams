/*
   Issue Description: CDM-29757
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CDM-29757', updatedon = now()
where intakeservreqchildremovalid = 'ecef130a-91dc-4176-bef3-defdcdf06ee5';