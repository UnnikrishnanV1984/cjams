/*
   Issue Description: CDM-34899
   Category/ Module  : Prod data fix to update sen details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update person set substanceclasses = '["BMJA"]', updatedby = 'CDM-34899', updatedon = now() 
where personid = 'af58fdce-8f85-45e6-8693-ff3e32589490';