/*
   Issue Description: CDM-21136
   Category/ Module  : Gap approval 
   Root cause: user wants  removal approval record
   Pull request# for code fix: 4995
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing 
set activeflag = 0, updatedby = 'CDM-21136', updatedon = now() 
where routingid = '38276011-e37b-4ad5-90cd-a259ef9f2324';