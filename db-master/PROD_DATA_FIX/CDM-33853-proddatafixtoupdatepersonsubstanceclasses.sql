/*
   Issue Description: CDM-33853
   Category/ Module  : Prod data fix to remove update substanceclasses
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update person set substanceclasses = '["BMJA"]', updatedby = 'CDM-33853', updatedon = now() 
where personid = 'b3f71de3-33cb-47ab-98da-d926525f2297';
