/*
   Issue Description: CDM-29776
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.intakeservreqchildremoval
SET updatedby='CDM-29776', updatedon=now(), activeflag=0
WHERE intakeservreqchildremovalid='c8285e3a-cf0d-48d4-8d82-a9bd282e4aa8';
