/*
   Issue Description: CDM-27611
   Category/ Module  :  approval inbox
   Root cause: user asked to remove the case which was from BALTIMORE 
   Pull request# for code fix: 7414
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   data fix needed.
*/
update routing set activeflag = 0, updatedby = 'CDM-27611', 
updatedon = now() where routingid = '52c67766-17ba-44a6-b9dd-06dc4b07ef41';