/*
   Issue Description: CDM-22766
   Category/ Module  : Prod data fix to remove draft removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-22766', updatedon = now() 
where intakeservreqchildremovalid = 'f012d2e6-b975-45f9-9f7d-45a63c0ab956' and activeflag = 1;
