/*
   Issue Description: CDM-17223
   Category/ Module  : Approval stuck 
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked tp remove the clid removal record
*/

update routing  set activeflag = 0 , updatedby ='CDM-17223',updatedon = now() 
	where routingid = 'a94c0a8f-fe52-49ea-916d-8340dab79e09';
