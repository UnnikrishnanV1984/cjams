/*
   Issue Description: CDM-29773
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CDM-29773', updatedon = now()
where intakeservreqchildremovalid in ('eda9c9d4-577e-411f-b885-5963cda62168');

