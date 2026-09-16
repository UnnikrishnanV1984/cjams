/*
   Issue Description: CDM-23159
   Category/ Module  : Prod data fix to activate CPS Case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 3049954
update intakeservicerequest set servicerequestnumber = '221020212506', activeflag = 1,intakeservreqtypeid = '247a8b26-cdee-4ce8-b36e-b37e49fd0103',
updatedby = 'CDM-23159', updatedon = now() where intakeserviceid = '357743c1-3964-4c17-8d48-f3514fa2d8d0';
