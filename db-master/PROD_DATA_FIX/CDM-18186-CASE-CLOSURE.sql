/*
   Issue Description: CDM-18186
   Category/ Module  :  case closure
   Root cause: user asked to remove from tree
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing
	set activeflag = 0, updatedby = 'CDM-18186', updatedon = now()
	where routingid = '5322034b-9b76-45fe-9ae2-df62825f5997';
