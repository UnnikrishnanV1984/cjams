/*
   Issue Description: CDM-18478
   Category/ Module  : pending approval 
   Root cause: Case shows pending in approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby = 'CDM-18478', updatedon = now() where routingid = 'bf3380c3-896c-49ff-a98b-1a8737b6d69b';