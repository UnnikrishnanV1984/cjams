/*
   Issue Description: CDM-33853
   Category/ Module  : Prod data fix to update sen details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





update person set substanceclasses = '["BMJA"]', updatedby = 'CDM-33853', updatedon = now() 
where personid = '7b6231b8-c4d4-43f6-afd5-4623225e8e35';
 