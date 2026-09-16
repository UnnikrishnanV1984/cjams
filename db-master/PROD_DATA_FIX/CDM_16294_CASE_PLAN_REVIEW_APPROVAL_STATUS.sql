/*
   Issue Description: CDM-16294
   Category/ Module  :  case approval
   Root cause: user wants to remove the approval list 
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag  = 0, updatedby = 'CDM-16294', updatedon = now()
	where routingid = '63cc3a01-e351-4803-8f85-8b7280876353';