/*
   Issue Description: CDM-17991
   Category/ Module  :  Received and approval for removal
   Root cause: user asked to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
	set activeflag = 0, updatedby = 'CDM-17991', updatedon = now()
	where routingid = 'd78a2019-fd8f-492e-9679-d99bf854a114';
