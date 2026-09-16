/*
   Issue Description: CDM-31329
   Category/ Module  : intake
   Root cause: user Need to update the Submission History Status to closed 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing set routingstatustypeid =8,updatedon=now() where objectid ='CW9611586';

update IntakeDAStatus set activeflag=1, updatedby='CDM-31329' ,updatedon=now() where intakenumber ='CW9611586';

