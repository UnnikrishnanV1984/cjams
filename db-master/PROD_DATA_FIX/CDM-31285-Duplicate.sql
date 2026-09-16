
/*
   Issue Description: CDM-31285
   Category/ Module  : Person
   Root cause: User request 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/









update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31285'
where personroleid  in('55e6bab0-c99e-4261-bf94-c5a66a8aa52e','fc7e9215-3958-41b8-b342-4306fd897d9f');

