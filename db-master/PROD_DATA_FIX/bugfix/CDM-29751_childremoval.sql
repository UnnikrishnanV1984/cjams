/*
   Issue Description: CDM-29751
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CDM-29751', updatedon = now()
where intakeservreqchildremovalid = 'e22d1bbd-3fc0-4ccb-ae7d-96dd494c63aa';