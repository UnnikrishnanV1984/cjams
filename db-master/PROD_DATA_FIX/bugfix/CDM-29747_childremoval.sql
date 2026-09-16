/*
   Issue Description: CDM-29747
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CDM-29747', updatedon = now()
where intakeservreqchildremovalid in ('a49def59-07c8-4447-b9df-5f069e63733d','2d559d39-5ec9-4e5c-8f75-9b982b29b09f');