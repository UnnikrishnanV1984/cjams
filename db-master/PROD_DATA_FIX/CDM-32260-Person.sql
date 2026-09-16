/*
   Issue Description: Person card update
   Category/ Module  : Person 
   Fix Provided: Did data fix to pull back the given person 
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/


update intakeservicerequestactor set 
updatedby = 'CDM-32260', updatedon = now(),
isprimary ='true' where intakeservicerequestactorid = '7dfaa116-757c-4fc3-bd27-041aecb552fa'
and actorid = '01b1e99a-8c87-46b6-abf1-320be8407106';