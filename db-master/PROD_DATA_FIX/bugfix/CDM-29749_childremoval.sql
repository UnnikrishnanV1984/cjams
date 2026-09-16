/*
   Issue Description: CDM-29749
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CDM-29749', updatedon = now()
where intakeservreqchildremovalid = '82df7ca0-6e64-4abe-9b96-7ef1d77805eb';
