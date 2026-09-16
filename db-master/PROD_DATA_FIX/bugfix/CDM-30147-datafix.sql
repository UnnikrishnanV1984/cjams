/*
   Issue Description: Person card update
   Category/ Module  : 
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/


update intakeservicerequestactor set 
updatedby = 'CDM-30147', updatedon = now(),
isprimary ='true' where intakeservicerequestactorid = 'b73308b7-15ce-41e6-86f2-57d1bed876e6'
and actorid = '1e66e49f-ba5d-484d-a327-183a6a79c023';