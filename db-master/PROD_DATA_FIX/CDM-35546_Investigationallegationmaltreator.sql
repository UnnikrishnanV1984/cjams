/*
   Issue Description: CDM-35546
   Category/ Module  : Prod data fix to remove the investigation findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update Investigationallegationmaltreators iai
set updatedon = now(), updatedby = 'CDM-35546', intakeservicerequestactorid = '78bb5642-1ac1-47d0-be33-cee1b8500248'
WHERE investigationallegationid in ('6f3264b6-8fd5-4e9a-a06e-88cf0dce35c5', 'aadc4450-f169-4aa5-a313-794d1c4db0c5') and iai.activeflag = 1;